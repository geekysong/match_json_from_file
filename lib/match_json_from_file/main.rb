module MatchJsonFromFile
  # The entry point for the executable
  class Main
    # input is a InputStream
    def initialize(input)
      @json_producer = Json::Producer.new(input)
    end

    # perform query on the output, where query is a string following specific syntax, and output is a stream
    def execute(argv, output)
      options = SearchOptionParser.new.parse(argv)
      json_matcher = Json::Matcher.new(options)
      json_output = Json::Output.new(output)

      json_output.start
      while(@json_producer.has_next?)
        json_object = @json_producer.next
        if json_matcher.match?(json_object)
          json_output.output(json_object)
        end
      end
      json_output.done
    end
  end
end
