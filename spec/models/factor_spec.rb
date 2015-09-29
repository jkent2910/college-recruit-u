require 'rails_helper'

RSpec.describe Factor, type: :model do
  it "validates presence of name" do
    expect(subject).to validate_presence_of(:name)
  end

  it "has many choices" do
    expect(subject).to have_many(:factor_choices)
  end
end
