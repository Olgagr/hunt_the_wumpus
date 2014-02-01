module HuntTheWumpus
		
	class Player
		
		attr_accessor :room, :senses, :encounters, :actions

		def initialize
			@senses = {}
			@encounters = {}
			@actions = {}
		end

		def sense(hazard, &callback)
			self.senses[hazard] = callback
		end

		def encounter(hazard, &callback)
			self.encounters[hazard] = callback
		end

		def action(name, &callback)
			self.actions[name] = callback
		end

		def enter(room)
			self.room = room
		end
		
	end

end