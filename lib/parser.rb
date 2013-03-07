class Parser
  def parse(file_contents)
    file_contents.split("\n").map do |line| 
      hash = {}
      line.split(",").map do |team_score|
        words = team_score.split(" ")
        score = words.pop.to_i
        team = words.join(" ")
        hash[team] = score
      end
      hash
    end
  end  
end