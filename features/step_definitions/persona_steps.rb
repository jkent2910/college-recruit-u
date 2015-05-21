# Sarah is a high school student
Given /^I am Sarah$/ do
  @user = FactoryGirl.create(:sarah)
end

# This could be a member of the general public
Given /^I am anybody$/ do
end
