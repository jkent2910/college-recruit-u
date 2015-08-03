class AddLogoToCollege < ActiveRecord::Migration
  def change
    add_attachment :colleges, :logo
  end
end
