require "Codebreaker/version"
require "Codebreaker/Score"

module Codebreaker

  class Game
    ATTEMPTS = 5

    def initialize
      @score = Score.new
    end

    def start
      set_default_parameters
      generate_random_arr
    end

    def generate_random_arr
      4.times {
        @random << get_random_number(1, 6)
      }
    end

    def submit_guesse num_array
      return check_result if game_over?

      @attempts += 1

      plus = ''
      minus = ''
      copy_random = @random.clone

      num_array.each.with_index do |elem, i|
        next if !copy_random.include?(elem)

        index = copy_random.index(elem)
        
        if i == index
          copy_random[i] = nil
          plus << '+'
        elsif num_array[index] == copy_random[index]
          copy_random[index] = nil
          plus << '+'
        else
          copy_random[index] = nil
          minus << '-'
        end
          
      end

      check_result plus + minus
    end

    def get_a_clue
      @random[get_random_number(0, 3)]
    end

    def get_random_number n, m
      n + rand(m)
    end

    def check_result *data
      if !data[0]
        game_over
      elsif data[0] == '++++'
        you_win
      else
        data[0]
      end
    end

    def game_over?
      return @attempts >= ATTEMPTS
    end

    def game_over
      "GAME OVER! SECTER CODE: #{@random}"
    end

    def you_win
      "YOU WIN"
    end

    def set_default_parameters
      @random = []
      @attempts = 0
    end

    def save_score name
      score = {
        name: name,
        attempts: @attempts
      }

      @score.save_score(score)
    end

    def get_result
      @score.get_score
    end
  end
end
