class CreateStudentProfileFactors < ActiveRecord::Migration
  def change
    create_table :factors do |t|
      t.string :name
    end

    create_table :factor_ratings do |t|
      t.references :student_profile, index: true, foreign_key: true
      t.references :factor, index: true, foreign_key: true
      t.integer :importance

      t.timestamps null: false
    end
  end
end
