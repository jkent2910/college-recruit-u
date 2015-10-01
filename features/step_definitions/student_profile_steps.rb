And(/^I have already created a profile$/) do
  @student_profile = FactoryGirl.create(:student_profile)
  @student_profile.student = @user
  @student_profile.save
end

Given(/^I set the importance of "(.*?)" to "(.*?)"$/) do |factor_name, importance|
  script = "$(\"label:contains(#{factor_name})\").siblings('div.ui-slider').slider('value', #{importance});"
  page.execute_script(script)
end

Given(/^I have a student profile$/) do
  FactoryGirl.create(:student_profile, student: @user)
end

Given(/^another student "(.*?)" has a student profile$/) do |name|
  student = FactoryGirl.create(:user)
  FactoryGirl.create(:student_profile, first_name: name, student: student)
end

Given(/^I am a fan of "(.*?)"$/) do |name|
  student_profile = StudentProfile.where(first_name: name).first
  @user.student_profile.become_fan_of student_profile
end

Given(/^"(.*?)" is a fan of mine$/) do |name|
  student_profile = StudentProfile.where(first_name: name).first
  student_profile.become_fan_of @user.student_profile
end

Given(/^I should see "(.*?)" listed in my fans$/) do |name|
  expect(page).to have_content name
end

Given(/^I should see that I am a fan of "(.*?)"$/) do |name|
  expect(page).to have_content name
end

Then(/^I should see a "(.*?)" factor of "(.*?)"$/) do |factor, value|
  expect(page).to have_selector(:xpath, "//div[text()='#{factor}']/following-sibling::div/div[@aria-valuenow='#{value}']")
end
