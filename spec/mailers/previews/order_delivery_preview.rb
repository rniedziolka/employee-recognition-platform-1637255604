# frozen_string_literal: true

class OrderDeliveryPreview < ActionMailer::Preview
  def delivery_confirmation_email
    OrderDeliveryMailer.with(order: order).delivery_confirmation_email
  end
end
