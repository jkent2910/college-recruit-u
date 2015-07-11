require 'rails_helper'

RSpec.describe CollegeStudentStatus, type: :model do
  it "belongs to student profile" do
    expect(subject).to belong_to(:student_profile)
  end

  it "belongs to college" do
    expect(subject).to belong_to(:college)
  end

end