module Codebreaker

  class Score
    def initialize
      @results = []
    end

    def save_score hash_info
      @results.push(hash_info)
    end

    def get_score
      @results
    end
  end
end
