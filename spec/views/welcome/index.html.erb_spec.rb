require 'rails_helper'

RSpec.describe "welcome/index.html.erb", type: :view do
  it "says 'College Recruit U'" do
    render
    assert_select "h1", text: 'College Recruit U'
  end
end
