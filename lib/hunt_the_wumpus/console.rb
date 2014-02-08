module HuntTheWumpus
	
	class Console

		attr_reader :player, :narrator	
		
		def initialize(player, narrator)
			@player = player
			@narrator = narrator
		end

		def show_room_description
			narrator.say '-----------------------------------------'
			narrator.say "You're in the rooom #{player.room.number}"

			player.explore_room

			narrator.say "Exits go to: #{player.room.exits.map(&:number)}"
		end

		def ask_player_to_act
			actions = {'m' => :move, 's' => :shoot, 'i' => :inspect}	
			
			accepting_player_input do |command, room_number|
				player.act actions[command], player.room.neighbor(room_number)
			end
		end

		private

		def accepting_player_input
			narrator.say '-----------------------------------------'
			command = narrator.ask 'What do you want to do ? (m)ove or (shoot) ?'

			unless ['m', 's'].include?(command)
				narrator.say 'Invalid action! Try again.'
				return
			end

			dest = narrator.ask('Where?').to_i

			unless player.room.exits.include?(dest)
				narrator.say 'You do not see such room.'
				return
			end

			yield(command, dest)
		end

	end

end