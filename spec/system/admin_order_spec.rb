# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminOrder', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin_user) { create(:admin_user) }
  let!(:employee) { create(:employee) }
  let!(:reward) { create(:reward, price: 1, delivery_method: 'online') }
  let(:reward2) { create(:reward, price: 2, delivery_method: 'online') }
  let!(:online_code) { create(:online_code, reward: reward) }
  let!(:kudo) { create(:kudo, receiver: employee) }

  it 'test admin orders actions' do
    sign_in(employee)

    visit root_path

    click_link 'Rewards'
    click_link 'Buy'
    expect(page).to have_content reward.title
    click_button 'Buy'
    click_link 'Orders'

    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price
    expect(page).to have_content reward.delivery_method

    login_as(admin_user)

    click_link 'Orders'

    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price
    expect(page).to have_content reward.delivery_method

    visit admin_rewards_path
    click_link 'Edit'
    fill_in 'reward[price]', with: reward2.price
    select('post', from: 'Delivery method')
    click_button 'Update Reward'
    expect(page).to have_content reward2.price
    expect(page).to have_content 'post'

    click_link 'Destroy', match: :first
    expect(page).to have_content 'Reward was successfully destroyed.'
  end
end
