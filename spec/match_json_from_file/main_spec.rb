require "spec_helper"

RSpec.describe MatchJsonFromFile::Main do
  let(:output) { StringIO.new }
  before { subject.execute(query, output) }

  context "success" do
    subject { MatchJsonFromFile::Main.new(input) }
    let(:query) { "name:songyy" }

    describe "empty" do
      let(:input) { "[]" }
      it { expect(output.string).to eq("[]\n") }
    end
  end
end
