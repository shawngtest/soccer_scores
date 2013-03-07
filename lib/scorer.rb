class Scorer
  def score(soccer_matches)
    result = {}
    soccer_matches.each do |match| 
      scored_match = score_match(match)
      scored_match.each do |team, score|
        result[team] = (result[team] || 0) + score
      end
    end
    result
  end

private
    def score_match(match)
      if match.values[0] > match.values[1]
        # A win is worth 3 points
        { match.keys[0] => 3, match.keys[1] => 0 }
      elsif match.values[0] < match.values[1]
        # A loss is worth 0 points
        { match.keys[0] => 0, match.keys[1] => 3 }
      else
        # A draw (tie) is worth 1 point
        { match.keys[0] => 1, match.keys[1] => 1 }
      end
    end
end