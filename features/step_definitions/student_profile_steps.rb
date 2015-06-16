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
  within "#my_fans" do
    expect(page).to have_content name
  end
end

Given(/^I should see that I am a fan of "(.*?)"$/) do |name|
  within "#fan_of" do
    expect(page).to have_content name
  end
end
