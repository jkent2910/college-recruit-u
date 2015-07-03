# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

factors = [
  "The size of the student body",
  "How close (or far away) the college is from your home",
  "The overall cost of a college",
  "How prestigious the college is",
  "What type of area the college is located in (rural, town, city, etc.)",
  "The type of college (community college, public, private, etc.)"
]

Factor.destroy_all
factors.each { |factor| Factor.create name: factor }
