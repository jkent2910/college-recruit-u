require 'rails_helper'

RSpec.describe Factor, type: :model do
  it "validates presence of name" do
    expect(subject).to validate_presence_of(:name)
  end

  it "has many choices" do
    expect(subject).to have_many(:factor_choices)
  end

  [3, 4, 7, 8].each do |n|
    specify "factor with id of #{n} is a progress factor" do
      expect(Factor.new(id: n)).to be_progress_factor
    end
  end

  [1, 2, 5, 6].each do |n|
    specify "factor with id of #{n} is not a progress factor" do
      expect(Factor.new(id: n)).not_to be_progress_factor
    end
  end
end
