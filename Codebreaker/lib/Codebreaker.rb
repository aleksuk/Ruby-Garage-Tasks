require "Codebreaker/version"

module Codebreaker
  # Your code goes here...
  class Game
    ATTEMPTS = 5

    def initialize
      @random = []
      @attempts = 0
    end

    def start
      generate_random_arr
    end

    def generate_random_arr
      4.times {|i|
        @random << get_random_number
      }
    end

    def submit_guess num_array
      return "GAME OVER\n #{@random}" if @attempts > ATTEMPTS

      @attempts += 1

      plus = ''
      minus = ''
      @copy_random = @random.clone

      num_array.each.with_index do |elem, i|
        next if !@copy_random.include?(elem)

        index = @copy_random.index(elem)

        if i == index
          @copy_random[i] = nil
          plus << '+'
        elsif num_array[index] != @copy_random[index]
          @copy_random[index] = nil
          minus << '-'
        end
      end

      check_result plus + minus
    end

    def get_random_number
      1 + rand(6)
    end

    def check_result data
      if data == '++++'
        'YOU WIN!'
      else
        data
      end
    end

  end
end
