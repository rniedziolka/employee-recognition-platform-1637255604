# frozen_string_literal: true

class CompanyValue < ApplicationRecord
  validates :title, presence: true
  has_many :kudos, dependent: :restrict_with_error
end
