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
    attach_file(File.absolute_path('./spec/files/images/default.jpg'))
    click_button 'Update Reward'
    expect(page).to have_content 'Example245'
    expect(page).to have_content '260.0'
    expect(page).to have_selector("img[src$='default.jpg']")
    expect(page).not_to have_content 'Example123'

    sign_in(employee)
    click_link 'Rewards'
    expect(page).to have_content 'Example245'
    expect(page).to have_content '260.0'
    expect(page).to have_selector("img[src$='default.jpg']")
    expect(page).not_to have_content 'Example123'

    login_as(admin_user)
    click_link 'Rewards'
    click_link 'Destroy'
    expect(page).to have_content 'Reward was successfully destroyed.'
    expect(page).not_to have_content 'Example245'
  end
end
