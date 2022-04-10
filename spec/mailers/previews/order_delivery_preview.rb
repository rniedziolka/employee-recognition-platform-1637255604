# frozen_string_literal: true

class OrderDeliveryPreview < ActionMailer::Preview
  def delivery_email
    OrderDeliveryMailer.with(order: order).delivery_email
  end
end
