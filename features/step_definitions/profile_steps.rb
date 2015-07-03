And(/^I have already created a profile$/) do
  @student_profile = FactoryGirl.create(:student_profile)
  @student_profile.student = @user
  @student_profile.save
end

Given(/^I set the importance of "(.*?)" to "(.*?)"$/) do |factor_name, importance|
  script = "$(\"label:contains(#{factor_name})\").siblings('div.ui-slider').slider('value', #{importance});"
  page.execute_script(script)
end
