require 'json'

module HuntTheWumpus

  class Cave

    attr_accessor :rooms, :cave_map

    def initialize
    	@cave_map = JSON.parse File.new(File.expand_path('../../../data/dodecahedron.json', __FILE__)).read	
    	@rooms = []
      build_cave
    end

    def room(index)
    	rooms.find { |r| r.number == index }		
    end

    def random_room
      rooms.sample
    end

    def move(hazard, rooms)
      rooms[:from].remove hazard
      rooms[:to].add hazard
    end

    def add_hazard(hazard, number_of_rooms)
      number_of_rooms.times do
        room = random_room
        redo if room.has?(hazard)
        room.add hazard
      end
    end

    private

    def build_cave
      (1..20).each do |n|
        rooms << Room.new(n)
      end

    	cave_map.each do |con|
    		room = room(con[0])
    		neighbor = room(con[1])

    		room.connect(neighbor) 
    	end
    end

    def add(room)
   		rooms << room unless room(room.number)
    end

  end

end
