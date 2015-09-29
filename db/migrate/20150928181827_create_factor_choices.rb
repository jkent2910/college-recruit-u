class CreateFactorChoices < ActiveRecord::Migration
  def change
    create_table :factor_choices do |t|
      t.integer :factor_id
      t.string :choice
    end
  end
end
