module HuntTheWumpus

  class Room

    attr_reader :number
    attr_accessor :hazards

    def initialize(number)
      @number = number
      @hazards = []
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

  end

end