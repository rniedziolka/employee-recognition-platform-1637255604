# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    if %w[delivered not_delivered].include?(params[:status])
      render :index, locals: { orders: Order.where(employee: current_employee).filter_by_status(params[:status]).includes([:reward]) }
    else
      render :index, locals: { orders: Order.where(employee: current_employee).includes([:reward]) }
    end
  end

  def new
    order_form = OrderForm.new
    render :new, locals: { order_form: order_form, reward: reward, employee: current_employee }
  end

  def create
    reward = Reward.find(order_form_params[:reward])
    order_form = OrderForm.new(order_form_params)
    if order_form.save
      redirect_to orders_path, notice: 'Reward bought'
    else
      render :new, locals: { order_form: order_form, reward: reward, delivery_method: reward.delivery_method, employee: current_employee }
    end
  end

  private

  def order_form_params
    ofp = params.require(:order_form).permit(:reward, :delivery_method, :street, :postcode, :city, :address_id)
    ofp[:employee] = current_employee
    ofp
  end

  def reward
    Reward.find(params[:reward])
  end
end
