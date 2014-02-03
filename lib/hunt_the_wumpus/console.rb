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

	end

end