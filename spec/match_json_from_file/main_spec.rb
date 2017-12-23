require "spec_helper"

# The feature spec - functional test
RSpec.describe MatchJsonFromFile::Main do
  let(:input_stream) { File.open("spec/resources/projects.json", "r") }
  let(:output) { StringIO.new }
  let(:json_producer) { MatchJsonFromFile::Json::Producer.new(input_stream) }
  let(:printer) { MatchJsonFromFile::Json::Output.new(output) }

  let(:options) { MatchJsonFromFile::SearchOptionParser.new.parse([query]) }
  let(:matcher) { MatchJsonFromFile::Json::Matcher.new(options) }

  subject { MatchJsonFromFile::Main.new(json_producer, printer, matcher) }

  let(:do_query) { subject.execute }

  context "success" do
    before { do_query }


    describe "empty" do
      let(:query) { "name:my last project" }
      it { expect(output.string).to eq("") }
    end

    describe "simple object" do
      let(:query) { "name:My first project" }
      let(:match_str) { '{"_id":101,"url":"http://example.com/projects-1","external_id":"9270ed79-35eb-4a38-a46f-35725197ea8d","name":"My first project","tags":["Exterior","Workplace Fun"],"created_at":"2016-05-21T11:10:28 -10:00"}' }

      it { expect(output.string).to eq(match_str + "\n") }
    end
  end

  context "failure" do
    let(:input_stream) { StringIO.new "[]" }

    describe "no query" do
      let(:query) { "" }

      it { expect { do_query }.to raise_error(RuntimeError, /undefined query/) }
    end

    describe "invalid json" do
      let(:query) { "key:value" }
      let(:input_stream) { StringIO.new "[not_valid]" }

      it { expect { do_query }.to raise_error(JSON::ParserError, /not_valid/) }
    end
  end

  context "performance" do
    pending "performance test via GC stats"
  end
end
