require_relative '../spec_helper'

describe HuntTheWumpus::Room do

  let(:room) { HuntTheWumpus::Room.new(12) }

  it 'has a number' do
    expect(room.number).to eq 12
  end

  it 'is empty when initialized' do
    expect(room.empty?).to be_true
  end

  it 'can contain hazard' do
    room.add(:wumpus)
    expect(room.empty?).to be_false
  end

  it 'is possible to check are there specific hazard' do
    room.add(:bats)
    expect(room.has?(:bats)).to be_true
  end

  it 'is possible to remove hazard' do
    room.add(:bats)
    room.remove(:bats)
    expect(room.has?(:bats)).to be_false
  end

  describe 'with neighbors' do

    let(:exit_numbers) { [11, 3, 7] }

    before do
      exit_numbers.each { |i| room.connect(HuntTheWumpus::Room.new(i)) }
    end

    it 'can find neighbor by number' do
      number = exit_numbers[0]
      expect(room.neighbor(number).number).to eq number
    end

    it 'can check connections bidirectionally' do
      number = exit_numbers[0]
      expect(room.neighbor(number).neighbor(room.number)).to eq room
    end

    it 'knows the numbers of all neighboring rooms' do
      expect(room.exits).to eq exit_numbers
    end

    it 'can choose a neighbor randomly' do
      expect(exit_numbers).to include(room.random_neighbor.number)
    end

    it 'is not safe if it has hazards' do
      room.add(:wumpus)
      expect(room.safe?).to be_false
    end

    it 'is not safe if its neighbors have hazards' do
      room.random_neighbor.add(:wumpus)
      expect(room.safe?).to be_false
    end

    it 'is safe when it and its neighbors have no hazards' do
      expect(room.safe?).to be_true
    end

  end

end