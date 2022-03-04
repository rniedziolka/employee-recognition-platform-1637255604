# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

employee1 = Employee.create!(email: 'user1@example.com', password: 'password')
employee2 = Employee.create!(email: 'user2@example.com', password: 'password')
employee3 = Employee.create!(email: 'user3@example.com', password: 'password')
employee4 = Employee.create!(email: 'user4@example.com', password: 'password')
employee5 = Employee.create!(email: 'user5@example.com', password: 'password')

admin = AdminUser.create!(email: 'admin@example.com', password: 'tojestto123')

company_value1 = CompanyValue.create!(title: "Patient")
company_value2 = CompanyValue.create!(title: "Helpful")

kudo1 = Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, employee_id: employee1.id, receiver_id: employee5.id, company_value: company_value1)
kudo2 = Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, employee_id: employee2.id, receiver_id: employee4.id, company_value: company_value2)
kudo3 = Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, employee_id: employee3.id, receiver_id: employee4.id, company_value: company_value1)
kudo4 = Kudo.create!(title: Faker::Food.dish, content: Faker::Food.description, employee_id: employee4.id, receiver_id: employee3.id, company_value: company_value2)

reward1 = Reward.create!(title: Faker::Food.dish, description: Faker::Food.description, price: 1)
reward2 = Reward.create!(title: Faker::Food.dish, description: Faker::Food.description, price: 3)
