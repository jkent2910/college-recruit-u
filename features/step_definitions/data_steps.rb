Given(/^the following factors:$/) do |table|
  table.hashes.each do | hash|
    FactoryGirl.create(:factor, hash)
  end
end
