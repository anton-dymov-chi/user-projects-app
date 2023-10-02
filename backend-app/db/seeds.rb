# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
users = FactoryBot.create_list(:employee, 20)
users.each { |user| FactoryBot.create_list(:assignment, 5, assignmentable_id: user.id, assignmentable_type: 'Employee') }