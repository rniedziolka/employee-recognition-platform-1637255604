# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin crud', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:employee1) { create(:employee) }
  let!(:employee2) { create(:employee) }
  let!(:admin) { create(:admin_user) }

  it 'test admin crud actions' do
    visit admin_root_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log in'
    expect(page).to have_content 'Admin dashboard'

    click_link 'New Admin Kudo'
    fill_in 'Title', with: 'Title test1'
    fill_in 'Content', with: 'Content Test1'
    select employee1.id, from: 'kudo[employee_id]'
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudo was successfully created.'

    click_link 'Edit'
    fill_in 'Title', with: 'Title test3'
    fill_in 'Content', with: 'Content Test3'
    select employee2.id, from: 'kudo[employee_id]'
    click_button 'Update Kudo'
    expect(page).to have_content 'Kudo was successfully updated.'

    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed'
    expect(page).not_to have_content 'Another Content Test1'
  end
end
