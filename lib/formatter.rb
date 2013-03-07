class Formatter
  def format(scores)
    result = []
    index = 0
    tie_index = 0
    last_value = nil

    # sort by value (score) descending, then by key (team name) ascending
    scores.sort_by { |key, value| [-value, key] }.each do |key, value|
      index += 1
      # we only reset the value of the tie_index when the current value is different than the previous value
      tie_index = index unless value == last_value

      result << "#{tie_index}. #{key}, #{value} pt#{value != 1 ? "s" : ""}"

      last_value = value
    end

    result.join("\n")
  end  
end