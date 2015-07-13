class RenameTypeToCollegeType < ActiveRecord::Migration
  def change
    rename_column :colleges, :type, :college_type
  end
end
