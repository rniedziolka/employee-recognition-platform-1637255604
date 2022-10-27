# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    def index
      respond_to do |format|
        format.html { render :index, locals: { orders: Order.includes(:employee).all.order(:status) } }
        format.csv { send_data Export::OrderExport.new(Order.includes(:employee).order(:status)).to_csv, filename: "Orders_#{Time.zone.today}.csv" }
      end
    end

    def update
      if order.delivered?
        redirect_to admin_orders_path, notice: 'Order was already delivered'
      elsif order.update(status: :delivered)
        OrderDeliveryMailer.with(order: order).delivery_confirmation_email.deliver_now
        redirect_to admin_orders_path, notice: 'Order delivered'
      else
        redirect_to admin_orders_path, notice: 'Order was not delivered'
      end
    end

    private

    def order
      @order ||= Order.find(params[:id])
    end
  end
end
