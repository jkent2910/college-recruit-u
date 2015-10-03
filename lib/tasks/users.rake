desc "Pull current user information"
task pull_users: :environment do 
  puts StudentProfile.first.full_name
end

