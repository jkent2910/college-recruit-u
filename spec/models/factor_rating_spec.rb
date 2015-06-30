require 'rails_helper'

RSpec.describe FactorRating, type: :model do
  describe "relationships" do
    it "belongs to student_profile" do
      expect(subject).to belong_to(:student_profile)
    end

    it "belongs to factor" do
      expect(subject).to belong_to(:factor)
    end
  end

  describe "validations" do
    it "validates presence of importance" do
      expect(subject).to validate_presence_of(:importance)
    end

    it "requires importance to be an integer between 1 and 5" do
      expect(subject).to validate_numericality_of(:importance).
                          only_integer.
                          is_greater_than_or_equal_to(0).
                          is_less_than_or_equal_to(5)
    end
  end
end
