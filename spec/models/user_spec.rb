require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a student profile" do
    expect(subject).to have_one(:student_profile)
  end
end
