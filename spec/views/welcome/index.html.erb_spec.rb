require 'rails_helper'

RSpec.describe "welcome/index.html.erb", type: :view do
  it "says 'YOUR FUTURE STARTS HERE'" do
    render
    assert_select "h1", text: 'YOUR FUTURE STARTS HERE'
  end
end
