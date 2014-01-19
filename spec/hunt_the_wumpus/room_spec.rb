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

end