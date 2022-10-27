# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:employee) { create(:employee) }
  let!(:kudo) { create(:kudo, receiver: employee) }
  let!(:company_value) { create(:company_value) }

  it 'tests post order with adding new address' do
    sign_in(employee)
    reward_post = create(:reward, price: 1, available_items: 1, delivery_method: 'post')
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
  end
end
