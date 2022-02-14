# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminReward crud', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin) { create(:admin_user) }

  it 'test admin crud actions' do
    visit admin_root_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log in'
    expect(page).to have_content 'Admin dashboard'
    click_link 'Rewards'

    click_link 'New Reward'
    fill_in 'Title', with: 'Example123'
    fill_in 'Description', with: 'Desc123'
    fill_in 'Price', with: '0'
    click_button 'Create Reward'
    expect(page).to have_content 'Price must be greater than or equal to 1'
    fill_in 'Price', with: '123'
    click_button 'Create Reward'
    expect(page).to have_content 'Reward was successfully created.'
    expect(page).to have_content 'Example123'
    expect(page).to have_content '123.0'

    click_link 'Edit'
    fill_in 'Title', with: 'Example245'
    fill_in 'Description', with: 'Desc12390'
    fill_in 'Price', with: '260'
    click_button 'Update Reward'
    expect(page).to have_content 'Example245'
    expect(page).to have_content '260.0'
    expect(page).not_to have_content 'Example123'

    click_link 'Destroy'
    expect(page).to have_content 'Reward was successfully destroyed.'
    expect(page).not_to have_content 'Example245'
  end
end
