require 'rails_helper'

RSpec.describe "student_profiles/show", type: :view do
  before(:each) do
    @student_profile = assign(:student_profile, StudentProfile.create!(
      :first_name => "First Name",
      :last_name => "Last Name",
      :gender => "Gender",
      :high_school => "High School",
      :graduation_year => "Graduation Year"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Gender/)
    expect(rendered).to match(/High School/)
    expect(rendered).to match(/Graduation Year/)
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
