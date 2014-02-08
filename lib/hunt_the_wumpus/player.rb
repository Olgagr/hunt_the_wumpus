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
			encounters.each do |hazard, action| 
				return action.call if room.has?(hazard)
			end
		end

		def explore_room
			senses.each do |hazard, action| 
				action.call if room.neighbors.any? { |n| n.has?(hazard) }
			end
		end

		def act(action, destination)
			actions[action].call(destination)
		end
		
	end

end