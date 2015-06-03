And(/^I have already created a profile$/) do
  @student_profile = FactoryGirl.create(:student_profile)
  @student_profile.student = @user
  @student_profile.save
end
