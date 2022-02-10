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

kudo1 = Kudo.create!(title: "At Kudos, we firmly believe that recognition is the best way to drive employee engagement and improve organizational performance. However, rewards can also be a terrific tool to enhance the employee experience.", content: "In practice, this recognition and communication first philosophy fosters connection, communication, and celebration of day-to-day contributions to significant accomplishments. We recommend that you keep the rewards component of your recognition program minimal or casual so they don't overshadow the program's goal. What people really want is to know they are valued, their work is noticed, and they belong. Rewards are nice but should not be the core focus. They should simply be a nice, low-cost benefit that reminds the team they work for a great company that cares about them.", employee_id: employee1.id, receiver_id: employee5.id, company_value: company_value1)
kudo2 = Kudo.create!(title: "It’s an age-old question we’ve all pondered before but one for which we rarely arrive at a cohesive solution. “How important is salary?”", content: "Salary will matter to people for a plethora of reasons, despite the fact that it may not always be the primary (nor even the secondary or tertiary) motivation for accepting a job offer or staying in a role.

Job security, benefits, company culture, travel, company reputation, career development and more all play a significant role in determining why people choose to remain with their organizations, and yet, salary is always a factor.

It’s fair to say, then, that the question of salary and its importance is certainly not black and white, but how far does its influence reach when you take a job or stay in your existing one?

And if salary can’t motivate employees to do their best work the way people assume it traditionally has, what’s the solution?

Let’s break this whole thing down further!", employee_id: employee2.id, receiver_id: employee4.id, company_value: company_value2)
kudo3 = Kudo.create!(title: "When it comes to assessing the value of a new career opportunity, employees will evaluate companies the same way they evaluate products. How are companies matching up in the eyes of potential employees?", content: "When it comes to assessing the value of a new career opportunity, employees will evaluate companies the same way they evaluate products. How are companies matching up in the eyes of potential employees?

More companies like Glassdoor are allowing for the honest, open, and uninhibited review of organizations globally. Many employees (both previous and current) take advantage of the unique opportunity to anonymously pick apart or praise companies.

Organizations may be grateful yet apprehensive of such platforms - the potential to receive both positive and negative reviews from happy or disgruntled team members can be scary! Candidates are quick to peruse platforms like Glassdoor to gain a better understanding of a company's culture and what it's like to work at an organization.", employee_id: employee3.id, receiver_id: employee4.id, company_value: company_value1)
kudo4 = Kudo.create!(title: "Can you easily describe your workplace culture? If you can’t, that could be a sign of a bigger problem. A weak or non-existent culture is not neutral; it signifies a lack of direction and cohesion. A strong and clearly defined culture is critical to taking your business to the next level.", content: "Can you easily describe your workplace culture? If you can’t, that could be a sign of a bigger problem. A weak or non-existent culture is not neutral; it signifies a lack of direction and cohesion. A strong and clearly defined culture is critical to taking your business to the next level.

Workplace culture is complex and unique to every organization, but at the same time, it’s often simply described as “the way things are done around here.”

Gallup expands on that by explaining that “culture is the unique way that your organization lives out its company purpose and delivers on its brand promise to its customers.” Culture will develop with or without your input. Without inputs and systems, culture will falter. With input, a system, and a strategy, culture can help you achieve your organization’s unique goals. That’s why organizations must define the culture they want and communicate it widely and often to stay top of mind and prevent unproductive fringe cultures from forming.", employee_id: employee4.id, receiver_id: employee3.id, company_value: company_value2)
kudo5 = Kudo.create!(title: "Today’s HR professionals and business leaders face unprecedented challenges in attracting, engaging, and retaining their people, and this challenge is expensive!", content: "Employee engagement is more important than ever, and HR departments are making the shift to using People Analytics to make better decisions. Using robust People Analytics takes the guesswork out of measuring employee engagement; it helps create an optimal employee experience to reduce turnover, absenteeism and increase productivity. Simply put, measuring the employee experience motivates people to change at all levels. The push to pull shift from surveys to passive behavioural data collection gives HR, managers, and employees more accurate data to act upon.", employee_id: employee5.id, receiver_id: employee1.id, company_value: company_value1)
