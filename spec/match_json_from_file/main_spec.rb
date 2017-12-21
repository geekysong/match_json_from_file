require "spec_helper"

RSpec.describe MatchJsonFromFile::Main do
  subject { MatchJsonFromFile::Main.new(input) }

  let(:output) { StringIO.new }
  let(:input) { File.open("spec/resources/projects.json", "r") }

  let(:do_query) { subject.execute(query, output) }

  context "success" do
    before { do_query }


    describe "empty" do
      let(:query) { "name:my last project" }
      it { expect(output.string).to eq("[]\n") }
    end

    describe "simple object" do
      let(:query) { "name:My first project" }
      let(:match_str) { '[{"_id":101,"url":"http://example.com/projects-1","external_id":"9270ed79-35eb-4a38-a46f-35725197ea8d","name":"My first project","tags":["Exterior","Workplace Fun"],"created_at":"2016-05-21T11:10:28 -10:00"}]' }

      it { expect(output.string).to eq(match_str + "\n") }
    end
  end

  context "failure" do
    let(:input) { "[]" }

    describe "no query" do
      let(:query) { "" }

      it { expect { do_query }.to raise_error(RuntimeError, /undefined query/) }
    end
  end
end
