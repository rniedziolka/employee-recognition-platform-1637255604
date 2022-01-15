# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employee account test', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'create user, sign up, sign out, log in' do
    visit root_path
    click_link 'Login page'
    fill_in 'email', with: 'anna.baskiewicz@dot.com'
    fill_in 'password', with: 'lubiepomarancze'
    fill_in 'password_confirmation', with: 'lubiepomarancze'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    visit pages_home_path
    click_link 'Sign out'
    click_link 'Login page'
    fill_in 'email', with: 'anna.baskiewicz@dot.com'
    fill_in 'password', with: 'lubiepomarancze'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
