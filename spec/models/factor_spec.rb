require 'rails_helper'

RSpec.describe Factor, type: :model do
  it "validates presence of name" do
    expect(subject).to validate_presence_of(:name)
  end
end
