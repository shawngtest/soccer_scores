require "spec_helper"

describe Formatter do
  describe "#format" do
    it "formats the output properly" do
      input = { "Tarantulas" => 6, "Lions" => 5, "FC Awesome" => 1, "Snakes" => 1, "Grouches" => 0 }

      expected = ["1. Tarantulas, 6 pts", 
                  "2. Lions, 5 pts",
                  "3. FC Awesome, 1 pt",
                  "3. Snakes, 1 pt",
                  "5. Grouches, 0 pts"].join("\n")

      result = Formatter.new.format(input)
      result.should == expected
    end
  end
end