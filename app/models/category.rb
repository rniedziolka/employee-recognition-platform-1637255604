# frozen_string_literal: true

class Category < ApplicationRecord
  validates :title, presence: true

  has_many :category_rewards, dependent: :restrict_with_error
  has_many :rewards, through: :category_rewards
end
