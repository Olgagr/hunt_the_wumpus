require_relative '../spec_helper'

describe HuntTheWumpus::Console do

	let(:room) { HuntTheWumpus::Room.new(1) } 
	let(:player) { HuntTheWumpus::Player.new }
	let(:narrator) { HuntTheWumpus::Narrator.new }
	let(:console) { HuntTheWumpus::Console.new(player, narrator) }

	it "shows room description" do
		player.enter room
		narrator.should_receive(:say).exactly(3).times
		player.should_receive(:explore_room)
		console.show_room_description				
	end	


end