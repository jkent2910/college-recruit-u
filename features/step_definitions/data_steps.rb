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

Given(/^the following student profiles:$/) do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:student_profile, hash)
  end
end
