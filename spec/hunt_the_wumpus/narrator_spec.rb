require_relative '../spec_helper'

describe HuntTheWumpus::Narrator do

	let(:narrator) { HuntTheWumpus::Narrator.new } 

	it "can tell the story" do
		STDOUT.should_receive(:puts).with('Hello world')
		narrator.say('Hello world')
	end

end