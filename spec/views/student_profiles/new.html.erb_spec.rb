require 'rails_helper'

RSpec.describe "student_profiles/new", type: :view do
  before(:each) do
    assign(:student_profile, StudentProfile.new(
      first_name: "Sarah",
      last_name: "Student",
      gender: "Female",
      high_school: "Valley High School",
      graduation_year: "2016"
    ))
  end

  it "renders new student_profile form" do
    render

    assert_select "form[action=?][method=?]", student_profiles_path, "post" do

      assert_select "input#student_profile_first_name[name=?]", "student_profile[first_name]"

      assert_select "input#student_profile_last_name[name=?]", "student_profile[last_name]"

      assert_select "input#student_profile_gender[name=?]", "student_profile[gender]"

      assert_select "select#student_profile_high_school[name=?]", "student_profile[high_school]"

      assert_select "select#student_profile_graduation_year[name=?]", "student_profile[graduation_year]"
    end
  end
end
