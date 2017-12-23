class MatchJsonFromFile::Json::Output
  def initialize(outputStream)
    @os = outputStream
  end

  def start
  end

  def done
  end

  def output(hash)
    @os << hash.to_json
    @os << "\n"
  end
end