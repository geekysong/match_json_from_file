module MatchJsonFromFile
  # The entry point for the executable
  class Main
    # input is a InputStream
    def initialize(producer, output, matcher)
      @producer = producer
      @output = output
      @matcher = matcher
    end

    # perform query on the output, where query is a string following specific syntax, and output is a stream
    def execute
      @output.start
      while(@producer.has_next?)
        json_object = @producer.next
        if @matcher.match?(json_object)
          @output.output(json_object)
        end
      end
      @output.done
    end
  end
end
