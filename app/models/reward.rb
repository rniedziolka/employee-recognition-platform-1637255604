# frozen_string_literal: true

class Reward < ApplicationRecord
  enum delivery_method: { online: 0, post: 1, pickup: 2 }

  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :title, :description, :price, presence: true
  validates :photo, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }

  has_many :orders, dependent: :nullify
  has_many :online_codes, dependent: :destroy
  has_many :category_rewards, dependent: :restrict_with_error
  has_many :categories, through: :category_rewards

  has_one_attached :photo

  scope :in_stock, -> { where('available_items > 0').or(where('online_codes_count > 0')) }

  def number_of_available_items
    delivery_method == 'online' ? online_codes_count : available_items
  end
end
