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

    private

    def build_cave
    	cave_map.each do |con|
    		room = room(con[0]) || Room.new(con[0])
    		neighbor = room(con[1]) || Room.new(con[1])

    		room.connect neighbor
    		add room
    		add neighbor
    	end
    end

    def add(room)
   		rooms << room unless room(room.number)
    end

  end

end
