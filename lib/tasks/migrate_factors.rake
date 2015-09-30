namespace :cru do

  desc "Seed factor choices and migrate factors"
  task seed_factor_choices_and_migrate_factors: :environment do
    # college-recruit-u_development=# select * from factors;
    #  id |                                 name
    # ----+-----------------------------------------------------------------------
    #   1 | The size of the student body
    #   2 | How close (or far away) the college is from your home
    #   3 | The overall cost of a college
    #   4 | How prestigious the college is
    #   5 | What type of area the college is located in (rural, town, city, etc.)
    #   6 | The type of college (community college, public, private, etc.)
    # (6 rows)

    factors = [
      {id: 1,
       new_name: "The size of the student body",
       choices: [
         {name: "Doesn't matter", value: 1},
         {name: "Small",          value: 2},
         {name: "Medium",         value: 3},
         {name: "Large",          value: 4}
       ]},
      {id: 2,
       new_name: "The distance the college is from your home",
       choices: [
         {name: "Doesn't matter",     value: 1},
         {name: "Very close",         value: 2},
         {name: "Within a few hours", value: 3},
         {name: "Far, far away",      value: 4}
       ]},
      {id: 3,
       new_name: "The overall cost of a college",
       choices: [
         {name: "Not important at all", value: 1},
         {name: "Not very important",   value: 2},
         {name: "Important",            value: 3},
         {name: "Very important",       value: 4},
         {name: "Extremely important",  value: 5}
       ]},
      {id: 4,
       new_name: "How prestigious the college is",
       choices: [
         {name: "Not important at all", value: 1},
         {name: "Not very important",   value: 2},
         {name: "Important",            value: 3},
         {name: "Very important",       value: 4},
         {name: "Extremely important",  value: 5}
       ]},
      {id: 5,
       new_name: "What type of area the college is located in",
       choices: [
         {name: "Doesn't matter", value: 1},
         {name: "Rural",          value: 2},
         {name: "Town",           value: 3},
         {name: "City",           value: 4},
         {name: "Metropolitan",   value: 5}
       ]},
      {id: 6,
       new_name: "The type of college",
       choices: [
         {name: "Doesn't matter",    value: 1},
         {name: "Private",           value: 2},
         {name: "Community College", value: 3},
         {name: "Public",            value: 4}
       ]},
      {id: 7,
       new_name: "Majors available",
       choices: [
         {name: "Not important at all", value: 1},
         {name: "Not very important",   value: 2},
         {name: "Important",            value: 3},
         {name: "Very important",       value: 4},
         {name: "Extremely important",  value: 5}
       ]},
      {id: 8,
       new_name: "Student activities available",
       choices: [
         {name: "Not important at all", value: 1},
         {name: "Not very important",   value: 2},
         {name: "Important",            value: 3},
         {name: "Very important",       value: 4},
         {name: "Extremely important",  value: 5}
       ]}
    ]

    FactorChoice.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('factor_choices')

    factors.each do |f|
      puts "Updating #{f[:new_name]}"
      factor = Factor.find_or_create_by(id: f[:id])
      factor.name = f[:new_name]
      factor.save!
      f[:choices].each do |c|
        factor.factor_choices.create(c)
      end
    end
  end

  desc "Migrate importance to factor choice"
  task migrate_importance_to_factor_choice: :environment do
    puts "Migrating importance to factor choice..."
    sql = "update factor_ratings fr
      set factor_choice_id = (select fc.id
      from factor_choices fc
      where fc.factor_id = fr.factor_id and fc.value = fr.importance)
      where fr.factor_id in (3, 4)"
    ActiveRecord::Base.connection.execute(sql)
    puts "done."
  end
end
