require 'rails_helper'

RSpec.describe FactorChoice, type: :model do
  it "belongs to factor" do
    expect(subject).to belong_to :factor
  end

  it "validates presence of factor" do
    expect(subject).to validate_presence_of(:factor)
  end

  it "validates presence of choice" do
    expect(subject).to validate_presence_of(:choice)
  end
end
