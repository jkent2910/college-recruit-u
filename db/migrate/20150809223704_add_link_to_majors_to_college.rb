class AddLinkToMajorsToCollege < ActiveRecord::Migration
  def change
    add_column :colleges, :link_to_majors, :string
  end
end
