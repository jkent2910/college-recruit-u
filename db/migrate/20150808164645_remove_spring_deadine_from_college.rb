class RemoveSpringDeadineFromCollege < ActiveRecord::Migration
  def change
    remove_column :colleges, :spring_deadine, :string
  end
end
