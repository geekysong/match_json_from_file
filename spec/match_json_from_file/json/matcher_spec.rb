require "spec_helper"

# The feature spec - functional test
RSpec.describe MatchJsonFromFile::Json::Matcher do
  subject { MatchJsonFromFile::Json::Matcher.new(options) }

  MatchOption = MatchJsonFromFile::Json::Matcher::MatchOption

  context "single match" do
    let(:options) { [ MatchOption.new("name", "oops", :'=') ] }

    it { expect(subject.match?({"name" => "oops"})).to be(true) }
    it { expect(subject.match?({"name" => "ooops"})).to be(false) }
    it { expect(subject.match?({"another" => "key"})).to be(false) }
  end

  context "multi match" do
    let(:options) { [ MatchOption.new("name", "oops", :'='), MatchOption.new("age", 18, :'=')] }
    it { expect(subject.match?({"name" => "oops", "age" => 18})).to be(true) }
    it { expect(subject.match?({"name" => "oops", "age" => 10})).to be(false) }
    it { expect(subject.match?({"name" => "oops"})).to be(false) }
    it { expect(subject.match?({"another" => "key"})).to be(false) }
  end

  describe "multi level" do
    let(:options) { [ MatchOption.new("name.first", "match", :'=')] }

    it { expect(subject.match?({"name" => {"first" => "match"}})).to be(true) }
    it { expect(subject.match?({"name" => {"first" => "mismatch"}})).to be(false) }
    it { expect(subject.match?({"name" => "no object"})).to be(false) }
  end
end
