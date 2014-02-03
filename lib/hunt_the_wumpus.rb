require_relative 'hunt_the_wumpus/room'
require_relative 'hunt_the_wumpus/cave'
require_relative 'hunt_the_wumpus/player'
require_relative "hunt_the_wumpus/narrator"
require_relative 'hunt_the_wumpus/console'

module HuntTheWumpus
  DATA_DIR = "#{File.dirname(__FILE__)}/../data"
end