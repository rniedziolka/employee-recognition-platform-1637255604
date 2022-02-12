# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

employee1 = Employee.where(email: 'ania@o2.pl').first_or_create!(password: 'password')
employee2 = Employee.where(email: 'marek.z@gmail.com"').first_or_create!(password: 'password')
employee3 = Employee.where(email: 'ola.gola@hotmail.com').first_or_create!(password: 'password')
employee4 = Employee.where(email: 'pawel.tkaczyk@wp.pl"').first_or_create!(password: 'password')
employee5 = Employee.where(email: 'zuza_gala@rv.com').first_or_create!(password: 'password')

admin = AdminUser.where(email: 'admin@example.com').first_or_create!(password: 'password')

company_value1 = CompanyValue.create!(title: "Patient")
company_value2 = CompanyValue.create!(title: "Helpful")

kudo1 = Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, employee_id: employee1.id, receiver_id: employee5.id, company_value: company_value1)
kudo2 = Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, employee_id: employee2.id, receiver_id: employee4.id, company_value: company_value2)
kudo3 = Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, employee_id: employee3.id, receiver_id: employee4.id, company_value: company_value1)
kudo4 = Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, employee_id: employee4.id, receiver_id: employee3.id, company_value: company_value2)
kudo5 = Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, employee_id: employee5.id, receiver_id: employee1.id, company_value: company_value1)
