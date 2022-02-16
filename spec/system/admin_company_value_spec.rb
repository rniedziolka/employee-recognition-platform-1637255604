# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminCompanyValue crud', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin_user) { create(:admin_user) }

  it 'test admin crud actions' do
    login_as(admin_user)
    visit admin_root_path

    click_link 'New Company Value'
    fill_in 'Title', with: 'Example123'
    click_button 'Create Company value'
    expect(page).to have_content 'Company Value was successfully created.'
    expect(page).to have_content 'Example'

    click_link 'Edit'
    fill_in 'Title', with: 'Example245'
    click_button 'Update Company value'
    expect(page).to have_content 'Example2'
    expect(page).not_to have_content 'Example123'

    click_link 'Destroy'
    expect(page).to have_content 'Company Value was successfully destroyed.'
    expect(page).not_to have_content 'Example245'
  end
end
