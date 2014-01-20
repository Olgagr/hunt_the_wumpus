module HuntTheWumpus

  class Room

    attr_reader :number
    attr_accessor :hazards, :neighbors

    def initialize(number)
      @number = number
      @hazards = []
      @neighbors = {}
    end

    def empty?
      hazards.empty?
    end

    def add(hazard)
      hazards << hazard
    end

    def has?(hazard)
      hazards.include?(hazard)
    end

    def remove(hazard)
      hazards.reject! { |h| h == hazard }
    end

    def connect(neighbor)
      neighbors[neighbor.number] = neighbor
      neighbor.neighbors[number] = self
    end

    def neighbor(number)
      neighbors[number]
    end

    def exits
      neighbors.keys
    end

    def random_neighbor
      random = neighbors.keys.shuffle[0]
      neighbors[random]
    end

    def safe?
      empty? && neighbors.all? { |k,v| v.empty? }
    end

  end

end