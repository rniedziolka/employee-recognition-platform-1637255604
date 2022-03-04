# frozen_string_literal: true

FactoryBot.define do
  factory :kudo do
    title { 'Title' }
    content { 'Content' }
    company_value
    employee { create(:employee) }
    receiver { create(:employee) }
  end
end
