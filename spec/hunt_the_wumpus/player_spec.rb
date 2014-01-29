require_relative '../spec_helper'


module HuntTheWumpus
	describe Player do
		
		let(:player) { HuntTheWumpus::Player.new }
		let(:empty_room) { HuntTheWumpus::Room.new(1) }
		
		let(:wumpus_room) do
			HuntTheWumpus::Room.new(2).tap { |e| e.add(:wumpus) }
		end 

		let(:bat_room) do
			HuntTheWumpus::Player.new(3).tap { |e| e.add(:bats) }
		end 

		let(:sensed) { Set.new } 
		let(:encounter) { Set.new } 

		before do
			empty_room.connect(bat_room)
			empty_room.connect(wumpus_room)
		end


	end
end