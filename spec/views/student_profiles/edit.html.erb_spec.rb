require 'rails_helper'

RSpec.describe "student_profiles/edit", type: :view do
  before(:each) do
    @student_profile = assign(:student_profile, StudentProfile.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :gender => "MyString",
      :high_school => "MyString",
      :graduation_year => "MyString"
    ))
  end

  it "renders the edit student_profile form" do
    render

    assert_select "form[action=?][method=?]", student_profile_path(@student_profile), "post" do

      assert_select "input#student_profile_first_name[name=?]", "student_profile[first_name]"

      assert_select "input#student_profile_last_name[name=?]", "student_profile[last_name]"

      assert_select "input#student_profile_gender[name=?]", "student_profile[gender]"

      assert_select "input#student_profile_high_school[name=?]", "student_profile[high_school]"

      assert_select "input#student_profile_graduation_year[name=?]", "student_profile[graduation_year]"
    end
  end
end
