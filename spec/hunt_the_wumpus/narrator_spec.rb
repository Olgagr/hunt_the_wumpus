require_relative '../spec_helper'

describe HuntTheWumpus::Narrator do

	let(:narrator) { HuntTheWumpus::Narrator.new } 

	it "can tell the story" do
		STDOUT.should_receive(:puts)
		player.should_receive(:explore_room)
		narrator.say('Hello world')
	end

end