module MatchJsonFromFile
  class SearchOptionParser
    # returns an array of @code{MatchOption}
    def parse(argv)
      query = argv.first
      raise "undefined query" if query.empty?

      query.split(";").map do |kv|
        k, v = kv.split(":")

        # TODO: cross reference too deep like this is not beautiful
        MatchJsonFromFile::Json::Matcher::MatchOption.new(k, v, :'=')
      end
    end
  end
end
