require 'rails_helper'

RSpec.describe "student_profiles/index", type: :view do
  include Devise::TestHelpers

  before(:each) do
    @student_user = FactoryGirl.create(:user)
    FactoryGirl.create(:student_profile, student: @student_user)
    sign_in @student_user

    assign(:student_profiles, [
      StudentProfile.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :gender => "Gender",
        :high_school => "High School",
        :graduation_year => "Graduation Year"
      ),
      StudentProfile.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :gender => "Gender",
        :high_school => "High School",
        :graduation_year => "Graduation Year"
      )
    ])
  end

  it "renders a list of student_profiles" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => "High School".to_s, :count => 2
    assert_select "tr>td", :text => "Graduation Year".to_s, :count => 2
  end
end
