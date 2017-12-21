require "spec_helper"

RSpec.describe MatchJsonFromFile::Main do
  subject { MatchJsonFromFile::Main.new(input) }

  let(:output) { StringIO.new }

  let(:do_query) { subject.execute(query, output) }

  context "success" do
    before { do_query }

    let(:query) { "name:songyy" }

    describe "empty" do
      let(:input) { "[]" }
      it { expect(output.string).to eq("[]\n") }
    end

    describe "simple object" do
      let(:input) { '[{"name": "songyy", "age":"10"}, {"name": "another", "age":"22"}]' }
      it { expect(output.string).to eq('[{"name":"songyy","age":"10"}]' + "\n") }
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