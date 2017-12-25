class MatchJsonFromFile::Json::Matcher
  MatchOption = Struct.new(:key, :value, :operator)

  def initialize(match_options)
    @options = match_options
  end

  def match?(object)
    @options.all? do |option|
      keys = option.key.split('.')
      data = dig(object, keys)
      type_aligned_value = type_align(data, option.value)

      case option.operator
      when :'='
        puts "trying to match, type_aligned_value: #{type_aligned_value}, actual data: #{data}"
        type_aligned_value == data
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

  def type_align(data, str_to_align)
    return str_to_align if data.nil?

    return str_to_align.to_i if data.is_a? Integer
    return str_to_align
  end
end