require_relative '../spec_helper'

describe HuntTheWumpus::Cave do

  let(:cave) { HuntTheWumpus::Cave.new }
  let(:rooms) { (1..20).map { |i| cave.room(i) } }

  it 'has 20 rooms that each connect to exactly three other rooms' do
    rooms.each do |room|
      expect(room.neighbors.count).to eq(3)
    end
  end

end