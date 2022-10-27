# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { not_delivered: 0, delivered: 1 }
  scope :filter_by_status, ->(status) { where status: status }

  serialize :reward_snapshot
  serialize :address_snapshot

  has_one :online_code, dependent: :destroy
  belongs_to :employee
  belongs_to :reward

  def transaction_price
    reward_snapshot.price
  end

  def order_title
    reward_snapshot.title
  end

  def order_description
    reward_snapshot.description
  end

  delegate :email, to: :employee, prefix: true
end
