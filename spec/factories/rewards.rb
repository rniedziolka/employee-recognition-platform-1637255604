# frozen_string_literal: true

FactoryBot.define do
  factory :reward do
    sequence(:title) { |n| "Title#{n}" }
    sequence(:description) { |n| "Description#{n}" }
    sequence(:price) { |n| "Price#{n}" }
  end
end
