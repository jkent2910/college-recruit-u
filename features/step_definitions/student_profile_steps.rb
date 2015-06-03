Given(/^I have a student profile$/) do
  FactoryGirl.create(:student_profile, student: @user)
end
