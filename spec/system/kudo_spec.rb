# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Kudo test', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee1) { create(:employee, number_of_available_kudos: 1) }
  let!(:employee2) { create(:employee, number_of_available_kudos: 2) }
  let!(:company_value1) { create(:company_value) }
  let!(:company_value2) { create(:company_value) }

  it 'crud kudo' do
    sign_in(employee1)

    visit new_kudo_path
    expect(page).to have_content 'Available kudos: 1'

    fill_in 'Title', with: 'Title test1'
    fill_in 'Content', with: 'Content Test1'
    select employee2.email
    select company_value1.title
    click_button 'Create Kudo'

    expect(page).to have_content 'Kudo was successfully created.'
    expect(page).to have_content 'Kudos'
    expect(page).to have_content 'Title test1'
    expect(page).to have_content 'Content Test1'
    expect(page).to have_content company_value1.title
    expect(page).to have_content 'Available kudos: 0'
    expect(page).to have_content '1'

    click_link 'New Kudo'
    expect(page).to have_content 'You do not have enough kudos to give away.'

    visit root_path
    click_link 'Edit'
    fill_in 'Content', with: 'Another Content Test1'
    select company_value2.title, from: 'kudo[company_value_id]'
    click_button 'Update Kudo'
    expect(page).to have_content 'Another Content Test1'
    expect(page).not_to have_content company_value1.title
    expect(page).to have_content company_value2.title

    travel 6.minutes do
      visit current_path
      expect(page).not_to have_link 'Edit'
      expect(page).not_to have_link 'Delete'
    end

    visit current_path
    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed'
    expect(page).not_to have_content 'Another Content Test1'
    expect(page).not_to have_content company_value2.title
    expect(page).to have_content '0'
  end
end
