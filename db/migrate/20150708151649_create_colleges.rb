class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
      t.string :name
      t.string :type
      t.string :city
      t.string :state
      t.string :region
      t.string :student_body_size
      t.string :twitter
      t.string :facebook
      t.string :instagram
      t.string :admissions_rep_page
      t.string :college_visit_page
      t.string :avg_gpa
      t.string :avg_act
      t.string :avg_sat
      t.string :percent_male
      t.string :percent_female
      t.string :percent_minority
      t.string :percent_international
      t.text :popular_majors
      t.string :number_of_essays
      t.string :number_of_recommendations
      t.string :spring_deadine
      t.string :summer_deadline
      t.string :fall_deadline
      t.string :early_admissions_deadline
      t.string :in_state_tuition
      t.string :out_of_state_tuition
      t.string :percent_receive_financial_aid
      t.text :notable_alumni

      t.timestamps null: false
    end
  end
end
