require "spec_helper"

describe Codebreaker::Game do

  let(:game) { Codebreaker::Game.new }

  before(:each) do
    game.start
  end

  it "When the game was started, should be generate 4 numbers" do
    expect(game.instance_variable_get(:@random).size).to eq(4)
  end

  context "#submit_guesse" do
    describe "should return tips, if the number is not correct" do

      test_data = [{
        random_code: [1, 2, 3, 4],
        input_code: [2, 5, 5, 5],
        expected_result: '-'
      }, {
        random_code: [1, 2, 3, 4],
        input_code: [1, 5, 6, 5],
        expected_result: '+'
      }, {
        random_code: [1, 2, 3, 4],
        input_code: [3, 2, 5, 6],
        expected_result: '+-'
      }, {
        random_code: [2, 2, 3, 2],
        input_code: [3, 2, 2, 2],
        expected_result: '++--'
      }]

      test_data.each do |option|
        it "#{option[:expected_result]}" do

          game.instance_variable_set(:@random, option[:random_code])
          expect(game.submit_guesse(option[:input_code])).to eq(option[:expected_result])
        end
      end
    end

    describe "return information about the end of the game" do
      it "message with secret code, if player loses" do

        expected_result = ''
        game.instance_variable_set(:@random, [1, 2, 3, 4])

        (Codebreaker::Game::ATTEMPTS + 1).times {
          expected_result = game.submit_guesse [3, 3, 3, 3]
        }

        expect(expected_result).to eq(game.game_over)
      end

      it "message about win, if player win" do

        game.instance_variable_set(:@random, [1, 2, 3, 4])
        expect(game.submit_guesse([1, 2, 3, 4])).to eq(game.you_win)
      end
    end

  end

  context "#start" do
    it "gives you the opportunity to play again" do
      
      game.instance_variable_set(:@random, [2, 6 ,6, 6])

      (Codebreaker::Game::ATTEMPTS + 1).times {
        game.submit_guesse [1, 2, 3, 4]
      }

      expect(game.instance_variable_get(:@attempts)).to eq(Codebreaker::Game::ATTEMPTS)
      game.start

      expect(game.instance_variable_get(:@attempts)).to eq(0)
    end
  end

  context "#get_a_clue" do
    it "user can get a hint at any time" do

      default_arr = [1, 2, 3, 4]
      input_arr = [5, 2, 3, 6]

      game.instance_variable_set(:@random, default_arr)
      game.submit_guesse input_arr
      game.submit_guesse input_arr

      hint = game.get_a_clue

      expect(game.instance_variable_get(:@random).include?(hint)).to eq(true)
    end
  end

  context "#save_score" do
    it "should save score" do

      expect(game.instance_variable_get(:@score)).to receive(:save_score).with(kind_of(Hash))
      game.save_score 'Some Name'
    end
  end

  context "#get_result" do
    it "should show last results" do

      expect(game.instance_variable_get(:@score)).to receive(:get_score).with(no_args())
      game.get_result
    end
  end
end
