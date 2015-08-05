require 'rails_helper'

describe StudentProfilesHelper do
  describe "#pronoun" do
    %w(female, Female, FEMALE).each do |g|
      it "returns her for #{g}" do
        expect(helper.pronoun(g)).to eq "her"
      end
    end

    %w(male, Male, MALE, other).each do |g|
      it "returns his for #{g}" do
        expect(helper.pronoun(g)).to eq "his"
      end
    end

    it "returns his for blank" do
      expect(helper.pronoun('')).to eq "his"
    end

    it "returns his for nil" do
      expect(helper.pronoun(nil)).to eq "his"
    end
  end
end
