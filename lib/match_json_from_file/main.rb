module MatchJsonFromFile
  # The entry point for the executable
  class Main
    # input is a InputStream
    def initialize(input)
      @input = input
    end

    # perform query on the output, where query is a string following specific syntax, and output is a stream
    def execute(query, output)
      output << "[]"
      output << "\n"
    end
  end
end
