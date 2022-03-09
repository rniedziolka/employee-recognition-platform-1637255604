# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminOrder', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin_user) { create(:admin_user) }
  let!(:employee) { create(:employee) }
  let!(:reward) { create(:reward, price: 1) }
  let(:reward2) { create(:reward, price: 2) }
  let!(:kudo) { create(:kudo, receiver: employee) }

  it 'test admin orders actions' do
    sign_in(employee)

    visit root_path

    click_link 'Rewards'
    click_link 'Buy'
    click_link 'Orders'

    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price

    login_as(admin_user)

    click_link 'Orders'

    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price

    visit admin_rewards_path
    click_link 'Edit'
    fill_in 'reward[price]', with: reward2.price
    click_button 'Update Reward'
    expect(page).to have_content reward2.price

    visit orders_path
    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price
    expect(page).not_to have_content reward2.price
  end
end
