# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    first_name { 'Bill' }
    last_name { 'White' }
    sequence(:email) { |i| "test#{i}@test.com" }
    password { 'password' }
    number_of_available_kudos { 10 }
  end
end
