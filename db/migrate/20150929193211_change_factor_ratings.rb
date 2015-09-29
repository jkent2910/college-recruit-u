class ChangeFactorRatings < ActiveRecord::Migration
  def change
    add_column :factor_ratings, :factor_choice, :integer
    rename_column :factor_choices, :choice, :name
    add_column :factor_choices, :value, :integer
  end
end
