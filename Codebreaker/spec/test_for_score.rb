require "spec_helper"

describe Codebreaker::Score do

  before(:all) do
    @test_data = [{
        name: 'Some Name',
        attempts: 4
      }, {
        name: 'Some Name2',
        attempts: 2
      }]
  end

  before(:each) do
    @score = Codebreaker::Score.new
  end

  context "#save_score" do
    it "should save informations about the game" do
      expect(@score.instance_variable_get(:@results).size).to eq(0)
      @score.save_score(@test_data[1])
      expect(@score.instance_variable_get(:@results).size).to eq(1)
    end
  end

  context "#get_score" do
    it "should return score" do

      @test_data.each do |option|
        @score.save_score option
      end

      expect(@score.instance_variable_get(:@results)).to eq(@test_data)
    end
  end
end
