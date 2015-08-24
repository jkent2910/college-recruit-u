require 'rails_helper'

RSpec.describe "welcome/index.html.erb", type: :view do
  it "says 'Your Future Starts Here'" do
    render
    assert_select "h1", text: 'Your Future Starts Here'
  end
end
