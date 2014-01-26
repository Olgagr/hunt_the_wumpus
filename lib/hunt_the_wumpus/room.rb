module HuntTheWumpus

  class Room

    attr_reader :number
    attr_accessor :hazards, :neighbors

    def initialize(number)
      @number = number
      @hazards = []
      @neighbors = []
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
      self.neighbors << neighbor
      neighbor.neighbors << self
    end

    def neighbor(number)
      neighbors.find { |n| n.number == number } 
    end

    def exits
      neighbors
    end

    def random_neighbor
      neighbors.sample
    end

    def safe?
      empty? && neighbors.all? { |n| n.empty? }
    end

  end

end