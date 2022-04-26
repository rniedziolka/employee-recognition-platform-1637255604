# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin crud', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee1) { create(:employee, number_of_available_kudos: 9) }
  let!(:employee2) { create(:employee, number_of_available_kudos: 6) }
  let!(:admin_user) { create(:admin_user) }
  let!(:company_value1) { create(:company_value) }
  let!(:company_value2) { create(:company_value) }

  it 'test admin crud actions for kudos' do
    login_as(admin_user)
    visit admin_root_path
    expect(page).to have_content 'Admin dashboard'

    click_link 'Kudos'
    click_link 'Create New Kudo'
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

  it 'test admin rud actions for employee' do
    login_as(admin_user)
    visit admin_root_path
    click_link 'Employees'
    expect(page).to have_content employee1.number_of_available_kudos
    expect(page).to have_content employee2.number_of_available_kudos
    click_link 'Edit', match: :first
    fill_in 'Email', with: 'test121@test.com'
    fill_in 'Number of available kudos', with: '54'
    click_button 'Update Employee'
    expect(page).to have_content 'Employee was successfully updated.'
    expect(page).to have_content 'test121@test.com'
    expect(page).to have_content 'Available kudos: 54'
    click_link 'Destroy', match: :first
    expect(page).to have_content 'Employee was successfully destroyed'
    expect(page).not_to have_content employee2.number_of_available_kudos
  end

  it 'add available kudos to employees' do
    login_as(admin_user)
    visit admin_root_path
    click_link 'Employees'

    expect(page).to have_content employee1.number_of_available_kudos
    expect(page).to have_content employee2.number_of_available_kudos
    click_link 'Add Kudos'
    click_button 'Add'
    expect(page).to have_content '19'
    expect(page).to have_content '16'
  end
end
