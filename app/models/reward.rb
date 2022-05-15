# frozen_string_literal: true

class Reward < ApplicationRecord
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :title, :description, :price, presence: true
  validates :photo, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }

  has_many :orders, dependent: :nullify
  has_many :category_rewards, dependent: :restrict_with_error
  has_many :categories, through: :category_rewards

  has_one_attached :photo
end
