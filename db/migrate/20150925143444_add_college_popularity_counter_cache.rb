class AddCollegePopularityCounterCache < ActiveRecord::Migration
  def up
    add_column :colleges, :college_student_statuses_count, :integer, default: 0, null: false
    College.pluck(:id).each { |id| College.reset_counters(id, :college_student_statuses) }
  end

  def down
    remove_column :colleges, :college_student_statuses_count
  end
end
