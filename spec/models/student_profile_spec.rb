require 'rails_helper'

RSpec.describe StudentProfile, type: :model do
  context "validations" do
    [:first_name, :last_name, :gender, :high_school, :graduation_year].each do |attr|
      it "validates presence of #{attr}" do
        expect(subject).to validate_presence_of(attr)
      end
    end
  end

  context "relationships" do
    it "belongs to student" do
      expect(subject).to belong_to :student
    end

    it "has many fan relationships" do
      expect(subject).to have_many :fan_relationships
    end

    it "has many fan of relationships" do
      expect(subject).to have_many :fan_of_relationships
    end

    it "has many fans" do
      expect(subject).to have_many :fans
    end

    it "is a fan of many" do
      expect(subject).to have_many :fan_of
    end
  end

  it "returns a full name based on first name and last name" do
    subject.first_name = "John"
    subject.last_name = "Jones"
    expect(subject.full_name).to eql "John Jones"
  end

  context "fandom" do
    before do
      @student_profile = FactoryGirl.create(:student_profile)
      @other_profile = FactoryGirl.create(:student_profile)
    end

    it "can test whether the student is a fan of another student" do
      expect(@student_profile).not_to be_fan_of(@other_profile)
    end

    it "can become a fan of another student" do
      @student_profile.become_fan_of(@other_profile)
      expect(@student_profile).to be_fan_of(@other_profile)
    end

    it "won't become a fan of another student more than once" do
      @student_profile.become_fan_of(@other_profile)
      @student_profile.become_fan_of(@other_profile)
      expect(@student_profile.fan_of).to contain_exactly(@other_profile)
    end

    it "can stop being a fan of another student" do
      @student_profile.become_fan_of(@other_profile)
      @student_profile.stop_being_a_fan_of(@other_profile)
      expect(@student_profile).not_to be_fan_of(@other_profile)
    end
  end
end
