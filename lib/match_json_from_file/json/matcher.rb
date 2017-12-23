class MatchJsonFromFile::Json::Matcher
  MatchOption = Struct.new(:key, :value, :operator)

  def initialize(match_options)
    @options = match_options
  end

  def match?(object)
    @options.all? do |option|
      case option.operator
      when :'='
        keys = option.key.split('.')
        dig(object, keys) == option.value
      else
        false
      end
    end
  end

  private
  def dig(object, keys)
    return false unless keys.is_a? Array
    return object if keys.empty?
    return false unless object.is_a? Hash
    return dig(object[keys.first], keys[1, keys.length])
  end
end