require 'rails_helper'

RSpec.describe "student_profiles/index", type: :view do
  include Devise::TestHelpers

  before(:each) do
    @student_user = FactoryGirl.create(:user)
    FactoryGirl.create(:student_profile, student: @student_user)
    sign_in @student_user

    assign(:student_profile, [
      StudentProfile.create!(
        first_name: "First Name",
        last_name: "Last Name",
        gender: "Female",
        high_school: "High School",
        graduation_year: "2016"
      ),
      StudentProfile.create!(
        first_name: "First Name",
        last_name: "Last Name",
        gender: "Female",
        high_school: "High School",
        graduation_year: "2017"
      )
    ])
  end

  it "renders a list of student_profiles" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/High School/)
  end
end
