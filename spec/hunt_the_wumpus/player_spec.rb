require_relative '../spec_helper'


module HuntTheWumpus

	describe Player do
		
		let(:player) { HuntTheWumpus::Player.new }
		let(:empty_room) { HuntTheWumpus::Room.new(1) }
		
		let(:wumpus_room) do
			HuntTheWumpus::Room.new(2).tap { |e| e.add(:wumpus) }
		end 

		let(:bat_room) do
			HuntTheWumpus::Room.new(3).tap { |e| e.add(:bats) }
		end 

		let(:sensed) { Set.new } 
		let(:encounter) { Set.new } 

		before do
			empty_room.connect(bat_room)
			empty_room.connect(wumpus_room)
		end

		describe "enter the room" do
			
			it "knows in which room he is" do
				player.enter(empty_room)
				expect(player.room.number).to eq 1 
			end	

			it "encounter all creatuers in room" do
				player.encounter :bats do
					player.enter empty_room
				end

				player.enter bat_room
				expect(player.room.number).to eq 1 	
			end

		end

		it "can explore room" do
			player.sense :wumpus do
				player.enter bat_room
			end

			player.enter empty_room
			player.explore_room
			expect(player.room.number).to eq 3
		end

		it "can remember senses" do
			player.sense :wumpus do
				'this is terrible smell!'
			end
			expect(player.senses[:wumpus].call).to eq 'this is terrible smell!'  
		end		

		it "can remember encounters" do
			player.encounter :wumpus do
				'aaaa!'
			end
			expect(player.encounters[:wumpus].call).to eq 'aaaa!' 
		end	

		it "can remember actions" do
			player.action :move do
				'go on'
			end
			expect(player.actions[:move].call).to eq 'go on' 
		end


	end
end