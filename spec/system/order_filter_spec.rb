# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order filtering', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee) { create(:employee) }
  let!(:order1) { create(:order, employee: employee, status: 'delivered') }
  let!(:order2) { create(:order, employee: employee, status: 'not_delivered') }

  it 'filters by the delivery status' do
    sign_in employee

    visit root_path
    click_link 'Orders'
    click_link 'All'
    expect(page).to have_content order1.reward.title
    expect(page).to have_content order2.reward.title

    click_link 'Delivered'
    expect(page).to have_content order1.reward.title
    expect(page).not_to have_content order2.reward.title

    click_link 'Not delivered'
    expect(page).not_to have_content order1.reward.title
    expect(page).to have_content order2.reward.title

    click_link 'All'
    expect(page).to have_content order1.reward.title
    expect(page).to have_content order2.reward.title
  end
end
