# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin crud', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee1) { create(:employee) }
  let!(:employee2) { create(:employee) }
  let!(:admin) { create(:admin_user) }
  let!(:company_value1) { create(:company_value) }
  let!(:company_value2) { create(:company_value) }

  it 'test admin crud actions' do
    visit admin_root_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log in'
    expect(page).to have_content 'Admin dashboard'

    click_link 'New Kudo'
    fill_in 'Title', with: 'Title test1'
    fill_in 'Content', with: 'Content Test1'
    select employee1.email, from: 'kudo[employee_id]'
    select employee1.email, from: 'kudo[receiver_id]'
    select company_value1.title, from: 'kudo[company_value_id]'
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudo was successfully created.'
    expect(page).to have_content 'Title test1'
    expect(page).to have_content 'Content Test1'
    expect(page).to have_content company_value1.title

    click_link 'Edit'
    fill_in 'Title', with: 'Title test3'
    fill_in 'Content', with: 'Content Test3'
    select employee2.email, from: 'kudo[employee_id]'
    select employee2.email, from: 'kudo[receiver_id]'
    select company_value2.title, from: 'kudo[company_value_id]'
    click_button 'Update Kudo'
    expect(page).to have_content 'Kudo was successfully updated.'
    expect(page).to have_content 'Title test3'
    expect(page).to have_content 'Content Test3'
    expect(page).not_to have_content 'Title test1'
    expect(page).not_to have_content 'Content Test1'
    expect(page).not_to have_content company_value1.title
    expect(page).to have_content company_value2.title

    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed'
    expect(page).not_to have_content 'Title test3'
    expect(page).not_to have_content 'Content Test3'
    expect(page).not_to have_content company_value2.title
  end
end
