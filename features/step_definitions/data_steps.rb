Given(/^the following factors?:$/) do |table|
  table.hashes.each do | hash|
    FactoryGirl.create(:factor, hash)
  end
end

Given(/^the following factor choices:$/) do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:factor_choice, hash)
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

Given(/^the colleges have the following student interest?:$/) do |table|
  table.hashes.each do |hash|
    college = College.where(name: hash[:name]).take
    CollegeStudentStatus::VALID_STATUSES.each do |status|
      n = hash[status].to_i
      n.times do
        sp = FactoryGirl.create(:student_profile)
        sp.add_or_update_college_status(college, status)
      end
    end
  end
end

Then(/^I should see the following colleges?:$/) do |expected_table|
  colleges = find("div.colleges-index").all("div.college")
  actual_table = [%w[name students]] + colleges.map do |college|
    name = college.all("a")[1].text.strip
    students = college.find("p").text.match(/\d+/)[0]
    [ name, students ]
  end
  expected_table.diff!(actual_table)
end
