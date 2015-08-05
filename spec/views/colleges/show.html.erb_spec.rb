require 'rails_helper'

RSpec.describe "colleges/show.html.erb", type: :view do
  include Devise::TestHelpers

  before do
    @college = FactoryGirl.create(:college, name: "Grandview University")
    @student_user = FactoryGirl.create(:user)
    @student_profile = FactoryGirl.create(:student_profile, student: @student_user)
    sign_in @student_user
  end

  it "displays the college name" do
    render
    assert_select "h1", text: "Grandview University"
  end

  it "still renders without a social media links" do
    @college.twitter = nil
    @college.facebook = nil
    @college.instagram = nil
    expect { render }.not_to raise_exception
  end

  it "still renders without admissions or visit links" do
    @college.admissions_rep_page = nil
    @college.college_visit_page = nil
    expect { render }.not_to raise_exception
  end
end
