# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

employee1 = Employee.create(email: "ania@o2.pl", password: "lubiepomarancze")
employee2 = Employee.create(email: "marek.z@gmail.com", password: "pass123456")
employee3 = Employee.create(email: "ola.gola@hotmail.com", password: "piszjak123")
employee4 = Employee.create(email: "pawel.tkaczyk@wp.pl", password: "hasloHASLO")
employee5 = Employee.create(email: "zuza_gala@rv.com", password: "jak1to2jest")

puts "Creating admin account"
AdminUser.where(email: "admin@example.com").first_or_create!(password: 'password')
