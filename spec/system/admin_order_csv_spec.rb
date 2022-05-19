# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order CSV check', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin_user) { create(:admin_user) }
  let!(:order) { create(:order) }

  it 'export csv with orders' do
    login_as(admin_user)

    visit admin_orders_path
    click_link 'Export Orders List'

    csv_header = CSV.parse(page.body)[0]
    expected_header = %w[order_title order_description employee_email transaction_price created_at status]

    expect(expected_header).to match_array(csv_header)

    csv_first_row = CSV.parse(page.body)[1]
    expected_first_row = [order.reward_snapshot.title, order.reward_snapshot.description, order.employee.email, order.reward_snapshot.price.to_s, order.created_at.to_s, order.status]

    expect(expected_first_row).to match_array(csv_first_row)
  end
end
