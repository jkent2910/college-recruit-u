require 'rails_helper'

RSpec.describe CollegeStudentStatus, type: :model do
  it "validates status" do
    expect(subject).to validate_inclusion_of(:status_name).in_array(CollegeStudentStatus::VALID_STATUSES)
  end

  it "belongs to student profile" do
    expect(subject).to belong_to(:student_profile)
  end

  it "belongs to college" do
    expect(subject).to belong_to(:college)
  end

  describe "scopes" do
    # These specs are slow. Are they worth it?

    before do
      college = FactoryGirl.create(:college)
      student_fan = FactoryGirl.create(:student_profile)
      @fan_status = student_fan.add_or_update_college_status(college, "Just a Fan")
      student_considering = FactoryGirl.create(:student_profile)
      @considering_status = student_considering.add_or_update_college_status(college, "Considering")
      student_applying = FactoryGirl.create(:student_profile)
      @applying_status = student_applying.add_or_update_college_status(college, "Applying")
      student_enrolling = FactoryGirl.create(:student_profile)
      @enrolling_status = student_enrolling.add_or_update_college_status(college, "Enrolling")
    end

    specify "just a fan" do
      expect(CollegeStudentStatus.just_a_fan).to contain_exactly(@fan_status)
    end

    specify "considering" do
      expect(CollegeStudentStatus.considering).to contain_exactly(@considering_status)
    end

    specify "applying" do
      expect(CollegeStudentStatus.applying).to contain_exactly(@applying_status)
    end

    specify "enrolling" do
      expect(CollegeStudentStatus.enrolling).to contain_exactly(@enrolling_status)
    end
  end
end
