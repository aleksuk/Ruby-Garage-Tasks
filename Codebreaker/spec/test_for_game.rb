require "spec_helper"

describe Codebreaker do
  let(:game) { Codebreaker::Game.new }

  it "When the game was started, should be generate 4 numbers" do
    expect(game).to receive(:get_random_number).exactly(4).times
    # expect(game).to receive(:generate_random_arr).once
    game.start
  end

  it "test" do
    expect(game.get_c).to eq(5)
  end

end