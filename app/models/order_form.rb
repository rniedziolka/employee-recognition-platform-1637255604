# frozen_string_literal: true

class OrderForm
  include ActiveModel::Model

  attr_accessor :reward, :delivery_method, :employee, :street, :postcode, :city, :address_id

  def save
    return false unless enough_funds

    ActiveRecord::Base.transaction do
      create_order
    end
    true
  rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    false
  end

  private

  def enough_funds
    return true if @employee.kudos_score >= Reward.find(@reward).price

    errors.add(:base, 'You have insufficient funds in your account.')
    false
  end

  def create_order
    create_address if Reward.find(@reward).delivery_method == 'post'
    Order.create!(reward: Reward.find(@reward), reward_snapshot: Reward.find(@reward), address_snapshot: @address, employee: @employee)
  end

  def create_address
    if @address_id.present?
      @address = Address.find(@address_id)
      @address.last_used = Time.current
      @address.save!
    else
      @address = Address.create!(employee: employee, street: street, city: city, postcode: postcode, last_used: Time.current)
    end
  end
end
