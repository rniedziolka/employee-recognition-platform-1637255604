# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = Order.where(employee: current_employee)
  end

  def create
    if current_employee.kudos_score < reward.price
      redirect_to rewards_path, notice: 'You have insufficient funds in your account.'
    else
      @order = Order.new(employee: current_employee, reward: reward, reward_snapshot: reward)
      @order.save
      redirect_to rewards_path, notice: 'Reward bought.'
    end
  end

  private

  def reward
    Reward.find(params[:reward])
  end
end
