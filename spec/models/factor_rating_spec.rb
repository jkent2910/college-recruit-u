require 'rails_helper'

RSpec.describe FactorRating, type: :model do
  describe "relationships" do
    it "belongs to student_profile" do
      expect(subject).to belong_to(:student_profile)
    end

    it "belongs to factor" do
      expect(subject).to belong_to(:factor)
    end

    it "belongs to factor_choice" do
      expect(subject).to belong_to(:factor_choice)
    end
  end

  it "validates presence of factor_choice_id" do
    expect(subject).to validate_presence_of(:factor_choice_id)
  end
end
