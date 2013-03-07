require "spec_helper"

describe Parser do
  describe "#parse" do
    it "parses input text to an array of soccer match hashes" do
      input = ["Lions 3, Snakes 3", 
               "Tarantulas 1, FC Awesome 0",
               "Lions 1, FC Awesome 1",
               "Tarantulas 2, Snakes 1",
               "Lions 4, Grouches 0"].join("\n")

      expected = [{ "Lions" => 3, "Snakes" => 3 },
                  { "Tarantulas" => 1, "FC Awesome" => 0 },
                  { "Lions" => 1, "FC Awesome" => 1 },
                  { "Tarantulas" => 2, "Snakes" => 1 },
                  { "Lions" => 4, "Grouches" => 0 }]

      result = Parser.new.parse(input)
      result.should == expected
    end
  end
end