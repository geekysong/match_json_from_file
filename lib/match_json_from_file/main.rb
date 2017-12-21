require 'json'

module MatchJsonFromFile
  # The entry point for the executable
  class Main
    # input is a InputStream
    def initialize(input)
      @input = input
    end

    # perform query on the output, where query is a string following specific syntax, and output is a stream
    def execute(query, output)
      raise "undefined query" if query.empty?

      parsed_query = parse_query(query)
      json_input = JSON.parse(@input)
      json_output = json_input.select { |obj| match?(obj, parsed_query) }

      output << json_output.to_json
      output << "\n"
    end

    private

    def parse_query(query_str)
      query_str.split(";").map { |kv| kv.split(":") }
    end

    def match?(object, parsed_query)
      parsed_query.all? { |match_field| k, v = match_field ; object[k] == v }
    end
  end
end
