# frozen_string_literal: true

class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true

  has_many :given_kudos, class_name: 'Kudo', dependent: :destroy, inverse_of: :employee
  has_many :received_kudos, class_name: 'Kudo', foreign_key: 'receiver_id', dependent: :destroy, inverse_of: :receiver
  has_many :orders, dependent: :nullify
  has_many :rewards, through: :orders
  has_one :address, dependent: :destroy

  def kudos_score
    received_kudos.count - orders.sum(&:transaction_price).to_i
  end

  def full_name
    if first_name && last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end

  def display_name
    first_name || email
  end
end
