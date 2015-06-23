require 'rails_helper'

RSpec.describe "student_profiles/show", type: :view do
  before(:each) do
    @student_profile = assign(:student_profile, StudentProfile.create!(
      first_name: "Sarah",
      last_name: "Student",
      gender: "Female",
      high_school: "Valley High School",
      graduation_year: "2016"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/missing.png/)
    expect(rendered).to match(/Sarah/)
    expect(rendered).to match(/Student/)
    expect(rendered).to match(/Female/)
    expect(rendered).to match(/valley.png/)
    expect(rendered).to match(/2016/)
  end

  it "contains a list of my fans" do
    render
    assert_select "h2", text: "My Fans"
  end

  it "contains a list of students of whom I am a fan" do
    render
    assert_select "h2", text: "I am a Fan of"
  end
end
