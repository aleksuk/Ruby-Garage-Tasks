require "Codebreaker/version"

module Codebreaker
  # Your code goes here...
  class Game
    ATTEMPTS = 5

    def initialize
      puts '11'
      @random = []
      @attempts = 0
    end

    def start
      generate_random_arr
    end

    def generate_random_arr
      4.times {
        @random << get_random_number
      }
    end

    def get_random_number
      1 + rand(6)
    end

    def get_c
      ATTEMPTS
    end

    def get_value
      @random
    end

  end
end
