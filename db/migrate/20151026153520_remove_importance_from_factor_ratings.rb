class RemoveImportanceFromFactorRatings < ActiveRecord::Migration
  def change
    remove_column :factor_ratings, :importance, :integer
  end
end
