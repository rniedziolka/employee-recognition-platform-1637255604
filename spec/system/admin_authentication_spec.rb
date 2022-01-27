# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin authentication' do
  before do
    driven_by(:rack_test)
  end

  let(:admin) { create(:admin_user) }

  it 'Allows admin to log in' do
    visit admin_root_path

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log in'

    expect(page).to have_content 'Admin dashboard'
    click_on 'Log out'
    expect(page).to have_content 'Signed out successfully.'
  end
end
