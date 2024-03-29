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

  it "still renders with all non-required fields blank" do
    @college = College.create(name: "Grinnell College", college_type: "Private", city: "Grinnell", state: "Iowa", region: "Town")
    expect { render }.not_to raise_exception
  end
end
