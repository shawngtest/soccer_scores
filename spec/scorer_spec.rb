require "spec_helper"

describe Scorer do
  describe "#score" do
    it "scores a draw (tie) as worth 1 point" do
      input = [{ "Lions" => 3, "Snakes" => 3 }]

      result = Scorer.new.score(input)
      result.should == { "Lions" => 1, "Snakes" => 1 }
    end

    it "scores a win as worth 3 points" do
      input = [{ "Tarantulas" => 1, "FC Awesome" => 0 }]

      result = Scorer.new.score(input)
      result["Tarantulas"].should == 3
    end

    it "scores a loss as worth 0 points" do
      input = [{ "Tarantulas" => 1, "FC Awesome" => 0 }]

      result = Scorer.new.score(input)
      result["FC Awesome"].should == 0
    end

    it "adds up points correctly" do
      input = [{ "Lions" => 3, "Snakes" => 3 },
               { "Tarantulas" => 1, "FC Awesome" => 0 },
               { "Lions" => 1, "FC Awesome" => 1 },
               { "Tarantulas" => 2, "Snakes" => 1 },
               { "Lions" => 4, "Grouches" => 0 }]

      expected = { "Tarantulas" => 6, "Lions" => 5, "FC Awesome" => 1, "Snakes" => 1, "Grouches" => 0 }

      result = Scorer.new.score(input)
      result.should == expected
    end
  end
end
