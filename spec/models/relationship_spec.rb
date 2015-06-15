require 'rails_helper'

RSpec.describe Relationship, type: :model do
  it "belongs to fan" do
    expect(subject).to belong_to(:fan)
  end

  it "belongs to fan_of" do
    expect(subject).to belong_to(:fan_of)
  end
end
