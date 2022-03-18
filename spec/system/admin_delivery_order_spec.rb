# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminDeliveryOrder', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin_user) { create(:admin_user) }
  let!(:order) { create(:order) }

  it 'test admin delivery order' do
    login_as(admin_user)

    visit admin_orders_path

    expect(page).to have_content 'Not delivered'

    click_link 'Deliver'

    expect(page).to have_content 'Delivered'
    expect(page).to have_content 'Order delivered'
  end
end
