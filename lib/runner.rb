Dir[File.expand_path('../', __FILE__) + "/*.rb"].each {|f| require f }

class Runner
  def run(args)
    if args.length != 2 
      puts "Please specify the input file path and the output file path, for example: \nruby soccer_scores \"/path/to/input.txt\" \"/path/to/output.txt\""
      return
    end

    input_path, output_path = args

    if !File.exists?(input_path)
      puts "The input file does not exist: \"#{input_path}\""
      return
    end

    puts "Processing input file: \"#{input_path}\""
    input = read_file(input_path)

    # do the actual work
    parsed_input = Parser.new.parse(input)
    scores = Scorer.new.score(parsed_input)
    output = Formatter.new.format(scores)

    puts "Writing output to file: \"#{output_path}\""
    write_file(output_path, output)

    puts "DONE!"
  end

  private
    def read_file(path)
      File.open(path, "rb") do |file|
        file.read
      end
    end

    def write_file(path, content)
      File.open(path, "w") { |file| file.write(content) }
    end
end