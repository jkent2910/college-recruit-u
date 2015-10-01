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

Given(/^I set the "(.*?)" factor to "(.*?)"$/) do |factor, choice|
  factor_class = factor.gsub(/\s+/, '-').downcase
  within("div.factor-#{factor_class}") do
    select(choice)
  end
end

Then(/^I should see a "(.*?)" factor of "(.*?)"$/) do |factor_name, value|
  factor = Factor.where(name: factor_name).take
  if factor.progress_factor?
    expect(page).to have_selector(:xpath, "//div[text()='#{factor_name}']/following-sibling::div/div/div[@aria-valuenow='#{value}']")
  else
    expect(page).to have_selector(:xpath, "//div[text()='#{factor_name}']/following-sibling::div/div[text()='#{value}']")
  end
end
