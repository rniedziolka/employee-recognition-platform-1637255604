# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminCompanyValue crud', type: :system do
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
    click_link 'Company Values'

    click_link 'New Company Value'
    fill_in 'company_value[title]', with: 'Example'
    click_button 'Create Company value'
    expect(page).to have_content 'Company Value was successfully created.'

    click_link 'Edit'
    fill_in 'company_value[title]', with: 'Example2'
    click_button 'Update Company value'
    expect(page).to have_content 'Company Value was successfully updated.'

    click_link 'Destroy'
    expect(page).to have_content 'Company Value was successfully destroyed.'
  end
end
