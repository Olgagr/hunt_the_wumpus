#!/usr/bin/env ruby
require_relative "../lib/hunt_the_wumpus"

# For testing, but also for restoring a world with the same conditions
srand(ARGV[0].to_i) if ARGV[0]

# World setup

cave = HuntTheWumpus::Cave.new

cave.add_hazard(:wumpus, 1)
cave.add_hazard(:pit, 3)
cave.add_hazard(:bats, 3)

# Player and narrator setup

player    = HuntTheWumpus::Player.new
narrator  = HuntTheWumpus::Narrator.new

console = HuntTheWumpus::Console.new(player, narrator)

# Senses

player.sense(:bats) do
  narrator.say("You hear a rustling sound nearby") 
end

player.sense(:wumpus) do
  narrator.say("You smell something terrible nearby")
end

player.sense(:pit) do
  narrator.say("You feel a cold wind blowing from a nearby cavern.")
end

# Encounters

player.encounter(:wumpus) do
  player.act(:startle_wumpus, player.room)
end

player.encounter(:bats) do
  narrator.say "Giant bats whisk you away to a new cavern!"

  old_room = player.room
  new_room = cave.random_room

  player.enter(new_room)

  cave.move(:bats, from: old_room, to: new_room)
end

player.encounter(:pit) do
  narrator.finish_story("You fell into a bottomless pit. Enjoy the ride!")
end

# Actions

player.action(:move) do |destination|
  player.enter(destination)
end

player.action(:shoot) do |destination|
  if destination.has?(:wumpus)
    narrator.finish_story("YOU KILLED THE WUMPUS! GOOD JOB, BUDDY!!!") 
  else
    narrator.say("Your arrow missed!")

    player.act(:startle_wumpus, cave.room_with(:wumpus))
  end
end

player.action(:startle_wumpus) do |old_wumpus_room|
  if [:move, :stay].sample == :move
    new_wumpus_room = old_wumpus_room.random_neighbor
    cave.move(:wumpus, from: old_wumpus_room, to: new_wumpus_room)

    narrator.say("You heard a rumbling in a nearby cavern.")
  end

  if player.room.has?(:wumpus)
    narrator.finish_story("You woke up the wumpus and he ate you!")
  end
end

# Kick off the event loop

player.enter(cave.entrance)

narrator.tell_story do
  console.show_room_description
  console.ask_player_to_act
end