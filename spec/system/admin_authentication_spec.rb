# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin authentication' do
  before do
    driven_by(:rack_test)
  end

  let(:admin_user) { build(:admin_user) }

  it 'Allows admin to log in' do
    login_as(admin_user)
    visit admin_root_path
    click_on 'Log out'
    expect(page).to have_content 'Signed out successfully.'
  end
end
