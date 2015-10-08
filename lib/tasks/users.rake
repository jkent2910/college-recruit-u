namespace :cru do
  desc "Pull current user information"
  task pull_users: :environment do
    puts StudentProfile.joins(:student).pluck(:first_name, :last_name, :email, :cell_number).map { |s| s.join(", ") }
  end
end
