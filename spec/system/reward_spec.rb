# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:employee) { create(:employee) }
  let!(:reward) { create(:reward, price: 1, delivery_method: 'online') }
  let!(:online_code) { create(:online_code, reward: reward) }

  it 'rewards test' do
    sign_in(employee)

    visit root_path

    click_link 'Rewards'
    expect(page).to have_content reward.title
    expect(page).not_to have_content reward.description
    expect(page).to have_content reward.price
    expect(page).to have_content '0'

    click_link 'Show'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price

    click_link 'Back'
    expect(page).to have_content reward.title
    expect(page).not_to have_content reward.description
    expect(page).to have_content reward.price

    click_link 'Buy'
    expect(page).to have_content reward.title
    click_link 'Buy'
    expect(page).to have_content 'You have insufficient funds'

    create(:kudo, receiver: employee)

    visit rewards_path
    expect(page).to have_content '1'
    click_link 'Buy'
    expect(page).to have_content reward.title
    click_button 'Buy'
    expect(page).to have_content 'Reward bought'
    expect(page).to have_content 'online'
  end

  it 'pagination check' do
    create_list(:reward, 25, delivery_method: 'post', available_items: 1)
    visit rewards_path
    expect(page).to have_link '3'
    expect(page).not_to have_link '4'
    click_link '3'
    expect(page).to have_content '3'
    expect(page).to have_content Reward.order(:title).last.title
    expect(page).not_to have_content Reward.order(:title).first.title
    click_link '2'
    expect(page).to have_content '2'
    expect(page).not_to have_content Reward.order(:title).last.title
    expect(page).not_to have_content Reward.order(:title).first.title
    click_link '1'
    expect(page).to have_content '1'
    expect(page).not_to have_content Reward.order(:title).last.title
    expect(page).to have_content Reward.order(:title).first.title
  end
end
