# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order', type: :system do
  let(:employee) { create(:employee) }
  let!(:reward_post) { create(:reward, price: 1, available_items: 1, delivery_method: 'post') }
  let!(:reward_online) { create(:reward, price: 1, delivery_method: 'online') }
  let!(:online_code) { create(:online_code, reward: reward_online) }
  let!(:kudo) { create(:kudo, receiver: employee) }
  let!(:company_value) { create(:company_value) }

  before do
    driven_by(:rack_test)
    online_code
    create(:kudo, employee: employee, receiver: employee, company_value: company_value)
    login_as employee, scope: :employee
  end

  it 'tests post and online order with adding new address' do
    visit orders_path
    expect(page).not_to have_content reward_post.title
    expect(page).not_to have_content reward_post.description
    expect(page).not_to have_content reward_post.price

    visit rewards_path
    expect(page).to have_content reward_post.title
    click_link 'Buy', match: :first
    expect(page).to have_content reward_post.title
    fill_in 'order[address][street]', with: 'Podrozna 21'
    fill_in 'order[address][postcode]', with: '01-234'
    fill_in 'order[address][city]', with: 'Krakow'
    click_button 'Buy'
    expect(page).to have_content 'Reward bought'

    visit orders_path
    expect(page).to have_content reward_post.title
    expect(page).to have_content reward_post.description
    expect(page).to have_content reward_post.price

    # tests online order
    visit rewards_path
    expect(page).not_to have_content reward_post.title
    click_link 'Buy'
    expect(page).to have_content reward_online.title
    click_button 'Buy'
    expect(page).to have_content 'Reward bought'

    visit orders_path
    expect(page).to have_content reward_online.title
    expect(page).to have_content reward_online.description
    expect(page).to have_content reward_online.price

    visit rewards_path
    expect(page).not_to have_content reward_online.title
  end
end
