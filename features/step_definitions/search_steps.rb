When(/^I search for "(.*?)"$/) do |query|
  within("form[role=search]", match: :first) do
    fill_in(:query, with: query)
    click_button("Go")
  end
end

Then(/^I should see the following colleges$/) do |table|
  college_results = find("#college-search-results")
  table.hashes.each do |college|
    expect(college_results).to have_text(college[:name])
  end
end

Then(/^I should see the following students$/) do |table|
  student_results = find("#student-search-results")
  table.hashes.each do |student|
    expect(student_results).to have_text(student[:name])
  end
end
