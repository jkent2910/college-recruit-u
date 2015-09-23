Given(/^the following factors?:$/) do |table|
  table.hashes.each do | hash|
    FactoryGirl.create(:factor, hash)
  end
end

Given(/^the following colleges?:$/) do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:college, hash)
  end
end

Given(/^the following student profiles?:$/) do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:student_profile, hash)
  end
end

Then(/^I should see the following colleges?:$/) do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Given(/^the colleges have the following student interest?:$/) do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end
