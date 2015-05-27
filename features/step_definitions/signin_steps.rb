Given /^I am not signed in$/ do
  step "I sign out"
end

Given /^I am signed in$/ do
  step "I sign in"
end

When /^I sign in$/ do
  step "I sign in using \"password\""
end

When /^I sign in using "([^"]*)"$/ do |password|
  step "I am on sign in page"
  step "I should see \"Sign in\""
  step "I fill in \"Email\" with \"#{@user.email}\""
  step "I fill in \"Password\" with \"#{password}\""
  step "I press \"Sign in\""
end

When(/^I sign in for the first time$/) do
  @user.sign_in_count = 0
  @user.save!
  step "I sign in"
end

When /^I sign out$/ do
  visit destroy_user_session_path
end

When /^I sign in with the wrong email$/ do
  step "I am on sign in page"
  step "I should see \"Sign in\""
  step "I fill in \"Email\" with \"bogus\""
  step "I fill in \"Password\" with \"password\""
  step "I press \"Sign in\""
end

When /^I sign in with the wrong password$/ do
  step "I sign in using \"bogus\""
end
