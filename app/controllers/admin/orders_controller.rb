# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    def index
      @orders = Order.includes(:employee)
    end
  end
end
