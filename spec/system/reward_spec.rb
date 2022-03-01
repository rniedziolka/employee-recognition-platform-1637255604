# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reward', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:employee) { create(:employee) }
  let!(:reward) { create(:reward, price: 1) }

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
    expect(page).to have_content 'You have insufficient funds in your account.'

    create(:kudo, receiver: employee)

    visit rewards_path
    expect(page).to have_content '1'
    click_link 'Buy'
    expect(page).to have_content 'Reward bought.'
    expect(page).to have_content '0'
  end
end
