require 'rails_helper'

RSpec.describe "student_profiles/show", type: :view do
  include Devise::TestHelpers

  before(:each) do
    @student_profile = assign(:student_profile, StudentProfile.create!(
      first_name: "Sarah",
      last_name: "Student",
      gender: "Female",
      high_school: "Valley High School",
      graduation_year: "2016",
      interests: ["Soccer", "Choir"]
    ))

    @student_user = FactoryGirl.create(:user)
    FactoryGirl.create(:student_profile, student: @student_user)
    sign_in @student_user
  end

  it "renders attributes" do
    render
    expect(rendered).to match(/missing.png/)
    expect(rendered).to match(/Sarah/)
    expect(rendered).to match(/Student/)
    expect(rendered).to match(/valley.png/)
    expect(rendered).to match(/2016/)
    expect(rendered).to match(/soccer.png/)
    expect(rendered).to match(/choir.png/)
  end

  it "contains a number of the students I am a fan of" do
    render
    assert_select "h4", text: "Fan of 0"
  end

  it "contains a number of students who are my fans" do
    render
    assert_select "h4", text: "0 Fans"
  end

  it "still renders without a high school logo" do
    @student_profile.high_school = "bogus"
    expect { render }.not_to raise_exception
  end
end
