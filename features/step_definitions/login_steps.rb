Given /^I am not logged in$/ do
  step "I log out"
end

Given /^I am logged in$/ do
  step "I log in"
end

When /^I log in$/ do
  step "I log in using \"password\""
end

When /^I log in using "([^"]*)"$/ do |password|
  step "I am on sign in page"
  step "I should see \"Log in\""
  step "I fill in \"Email\" with \"#{@user.email}\""
  step "I fill in \"Password\" with \"#{password}\""
  step "I press \"Log in\""
end

When /^I log out$/ do
  visit destroy_user_session_path
end

When /^I log in with the wrong email$/ do
  step "I am on sign in page"
  step "I should see \"Log in\""
  step "I fill in \"Email\" with \"bogus\""
  step "I fill in \"Password\" with \"password\""
  step "I press \"Log in\""
end

When /^I log in with the wrong password$/ do
  step "I log in using \"bogus\""
end
