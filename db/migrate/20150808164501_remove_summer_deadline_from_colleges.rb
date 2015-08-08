class RemoveSummerDeadlineFromColleges < ActiveRecord::Migration
  def change
    remove_column :colleges, :summer_deadline, :string
  end
end
