# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employee account test', type: :system do
before do
   driven_by(:rack_test)
end
  let!(:employee) { FactoryBot.create(:employee) }
  let(:valid_attributes) { FactoryBot.attributes_for(:employee) }

  it 'create user, sign up, sign out, log in' do
    visit root_path
    click_link 'Login page'
    click_link 'Sign up'
    fill_in 'Email', with: valid_attributes[:email]
    fill_in 'Password', with: valid_attributes[:password]
    fill_in 'Password confirmation', with: valid_attributes[:password]
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    click_link 'Home page'
    click_link 'Sign out'
    click_link 'Login page'
    fill_in 'Email', with: valid_attributes[:email]
    fill_in 'Password', with: valid_attributes[:password]
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
