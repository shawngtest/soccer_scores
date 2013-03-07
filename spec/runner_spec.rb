require "spec_helper"

describe Runner do
  describe "#run" do
    before do
      # silence output messages when running test
      @orig_stdout = $stdout
      $stdout = StringIO.new

      # save the path names for consistency
      @input_path = "input.txt"
      @output_path = "output.txt"

      # stub out i/o so we don't accidentally hit the file system
      File.stub(open: nil)
    end

    after do
      # re-enable output messages after running test
      $stdout = @orig_stdout
    end

    it "prints an error when missing input file path argument" do
      $stdout.should_receive(:puts).with(/please specify the input file path and the output file path/i)
      Runner.new.run([])
    end

    it "prints an error when missing output file path argument" do
      $stdout.should_receive(:puts).with(/please specify the input file path and the output file path/i)
      Runner.new.run([@input_path])
    end

    it "prints an error when input file does not exist" do
      File.stub(:exists?).with(@input_path) { false }
      $stdout.should_receive(:puts).with(/the input file does not exist/i)
      Runner.new.run([@input_path, @output_path])
    end

    it "should create correct output file" do
      input = ["Lions 3, Snakes 3", 
               "Tarantulas 1, FC Awesome 0",
               "Lions 1, FC Awesome 1",
               "Tarantulas 2, Snakes 1",
               "Lions 4, Grouches 0"].join("\n")

      expected = ["1. Tarantulas, 6 pts", 
                  "2. Lions, 5 pts",
                  "3. FC Awesome, 1 pt",
                  "3. Snakes, 1 pt",
                  "5. Grouches, 0 pts"].join("\n")
      
      input_file = stub_input_file(@input_path, input)
      output_file = stub_output_file(@output_path)

      output_file.should_receive(:write).with(expected)

      Runner.new.run([@input_path, @output_path])
    end

    def stub_input_file(path, contents)
      input_file = StringIO.new(contents || "")
      File.stub(:open).with(path, "rb") { |&block| block.yield input_file }
      File.stub(:exists?).with(path) { contents != nil }
      input_file
    end

    def stub_output_file(path)
      output_file = StringIO.new
      File.stub(:open).with(path, "w") { |&block| block.yield output_file }
      output_file
    end
  end
end