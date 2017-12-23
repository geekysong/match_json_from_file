require "json"

# for a given Input Stream of JSON array, parse JSON object one line
class MatchJsonFromFile::Json::Producer
  def initialize(input_stream)
    @objects = JSON.parse(input_stream.readlines.join("\n"))
    @ptr = 0
  end

  def has_next?
    @objects.length > @ptr
  end

  def next
    @ptr += 1
    @objects[@ptr - 1]
  end
end