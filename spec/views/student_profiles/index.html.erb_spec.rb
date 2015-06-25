require 'rails_helper'

RSpec.describe "student_profiles/index", type: :view do
  include Devise::TestHelpers

  before(:each) do
    @student_user = FactoryGirl.create(:user)
    FactoryGirl.create(:student_profile, student: @student_user)
    sign_in @student_user

    assign(:student_profiles, [
      StudentProfile.create!(
        first_name: "First Name",
        last_name: "Last Name",
        gender: "Gender",
        high_school: "High School",
        graduation_year: "2016"
      ),
      StudentProfile.create!(
        first_name: "First Name",
        last_name: "Last Name",
        gender: "Gender",
        high_school: "High School",
        graduation_year: "2017"
      )
    ])
  end

  it "renders a list of student_profiles" do
    render
    assert_select "tr>td", text: "First Name", count: 2
    assert_select "tr>td", text: "Last Name", count: 2
    assert_select "tr>td", text: "Gender", count: 2
    assert_select "tr>td", text: "High School", count: 2
    assert_select "tr>td", text: "2016", count: 1
    assert_select "tr>td", text: "2017", count: 1
  end
end
