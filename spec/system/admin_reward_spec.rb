# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminReward crud', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:admin_user) { create(:admin_user) }
  let(:employee) { create(:employee) }

  it 'test admin crud actions' do
    login_as(admin_user)
    visit admin_root_path
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
    select('post', from: 'Delivery method')
    attach_file(File.absolute_path('./spec/files/images/default.jpg'))
    click_button 'Update Reward'
    expect(page).to have_content 'Example245'
    expect(page).to have_content '260.0'
    expect(page).to have_selector("img[src$='default.jpg']")
    expect(page).to have_content 'post'
    expect(page).not_to have_content 'Example123'

    sign_in(employee)
    click_link 'Rewards'
    expect(page).to have_content 'Example245'
    expect(page).to have_content '260.0'
    expect(page).to have_selector("img[src$='default.jpg']")
    expect(page).to have_content 'post'
    expect(page).not_to have_content 'Example123'

    login_as(admin_user)
    click_link 'Rewards'
    attach_file(File.absolute_path('./spec/files/docs/rewards_external_data.csv'))
    click_button 'Import CSV file'
    expect(page).to have_content '86'
    expect(page).to have_content 'Sweet Small'
    expect(page).to have_content 'post'
    attach_file(File.absolute_path('./spec/files/docs/rewards_external_data_updated.csv'))
    click_button 'Import CSV file'
    expect(page).to have_content '58'
    expect(page).to have_content 'Sour Big'
    expect(page).to have_content 'online'
    expect(page).not_to have_content '86'
    expect(page).not_to have_content 'Sweet Small'

    click_link 'Destroy', match: :first
    expect(page).to have_content 'Reward was successfully destroyed.'
  end
end
