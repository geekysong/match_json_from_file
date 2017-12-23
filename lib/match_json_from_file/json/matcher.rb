class MatchJsonFromFile::Json::Matcher
  MatchOption = Struct.new(:key, :value, :operator)

  def initialize(match_options)
    @options = match_options
  end

  def match?(object)
    @options.all? do |option|
      case option.operator
      when :'='
        puts "result: #{object[option.key] == option.value}"
        object[option.key] == option.value
      else
        false
      end
    end
  end
end