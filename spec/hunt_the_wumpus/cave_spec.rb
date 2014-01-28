require_relative '../spec_helper'

describe HuntTheWumpus::Cave do

  let(:cave) { HuntTheWumpus::Cave.new }
  let(:rooms) { (1..20).map { |i| cave.room(i) } }

  it 'has 20 rooms that each connect to exactly three other rooms' do
    rooms.each do |room|
      expect(room.neighbors.count).to eq(3)
    end
  end

  it 'has 20 rooms which all neighbors are connected with this room' do
  	rooms.each do |room|
  		expect(room.neighbors.all? {|n| n.neighbors.include?(room)}).to be_true
  	end
  end

  it "can select rooms at random" do
    expect(Set[*rooms]).to include(cave.random_room) 
  end

  it "can move hazards from one room to another" do
    room = cave.random_room
    neighbor = room.neighbors.first

    room.add(:bats)

    cave.move :bats, from: room, to: neighbor
    expect(neighbor.has?(:bats)).to be_true     
  end

  it "can add hazards at random to a specific number rooms" do
    cave.add_hazard :bats, 3
    expect(rooms.select { |r| r.has?(:bats) }.size).to eq 3  
  end

  it "can find room with a particular hazard" do
    cave.add_hazard(:wumpus, 1)
    expect(cave.room_with(:wumpus).has?(:wumpus))
  end

  it "can find a safe room to sarve as an entrance" do
    cave.add_hazard(:wumpus, 1)
    cave.add_hazard(:pit, 3)
    cave.add_hazard(:bats, 3)

    entrance = cave.entrance

    expect(entrance.safe?).to be_true 
  end

end