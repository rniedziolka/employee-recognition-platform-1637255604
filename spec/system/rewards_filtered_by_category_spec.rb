# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Rewards filtering by category', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:reward1) { create(:reward, delivery_method: 'post', available_items: 1) }
  let(:reward2) { create(:reward, delivery_method: 'post', available_items: 1) }
  let!(:employee) { create(:employee) }
  let!(:category_reward1) { create(:category_reward, reward: reward1) }
  let!(:category_reward2) { create(:category_reward, reward: reward2) }

  it 'reward filtered category test' do
    sign_in(employee)

    visit root_path

    click_link 'Rewards'
    expect(page).to have_content category_reward1.reward.title
    expect(page).to have_content category_reward2.reward.title

    click_link category_reward1.category.title
    expect(page).to have_content category_reward1.reward.title
    expect(page).not_to have_content category_reward2.reward.title

    click_link category_reward2.category.title
    expect(page).not_to have_content category_reward1.reward.title
    expect(page).to have_content category_reward2.reward.title

    click_link 'All'
    expect(page).to have_content category_reward1.reward.title
    expect(page).to have_content category_reward2.reward.title
  end
end
