# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    employee
    sequence(:street) { |n| "street#{n}" }
    sequence(:postcode) { |n| "postcode#{n}" }
    sequence(:city) { |n| "city#{n}" }
    last_used { Time.current }
  end
end
