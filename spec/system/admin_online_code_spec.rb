# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminOnlineCodes', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'adds correct unique code and show success message' do
    reward_online = create(:reward, delivery_method: 'online')
    online_code = build(:online_code, reward: reward_online)
    admin = create(:admin_user)
    login_as admin, scope: :admin_user
    visit admin_online_codes_path
    click_link 'New Online Code'
    fill_in 'online_code[code]', with: online_code.code
    select reward_online.title, from: 'online_code[reward_id]'
    click_button 'Create Online code'
    expect(page).to have_content 'Online code was successfully added.'
    expect(page).to have_content online_code.code
  end

  it 'shows error when adding empty code' do
    admin = create(:admin_user)
    login_as admin, scope: :admin_user
    visit admin_online_codes_path
    click_link 'New Online Code'
    click_button 'Create Online code'
    expect(page).to have_content "Code can't be blank"
  end

  it 'shows error when adding not unique code' do
    reward_online = create(:reward, delivery_method: 'online')
    online_code = create(:online_code, reward: reward_online)
    admin = create(:admin_user)
    login_as admin, scope: :admin_user
    visit admin_online_codes_path
    click_link 'New Online Code'
    fill_in 'online_code[code]', with: online_code.code
    select reward_online.title, from: 'online_code[reward_id]'
    click_button 'Create Online code'
    expect(page).to have_content 'Code has already been taken'
  end

  it 'edits exisitng code' do
    reward_online = create(:reward, delivery_method: 'online')
    online_code = create(:online_code, reward: reward_online)
    online_code_edited = build(:online_code, reward: reward_online)
    admin = create(:admin_user)
    login_as admin, scope: :admin_user
    visit admin_online_codes_path
    expect(page).to have_content online_code.code
    click_link 'Edit'
    fill_in 'online_code[code]', with: online_code_edited.code
    click_button 'Update Online code'
    expect(page).to have_content 'Online code was successfully updated.'
    expect(page).not_to have_content online_code.code
    expect(page).to have_content online_code_edited.code
  end

  it 'destroys existing code' do
    reward_online = create(:reward, delivery_method: 'online')
    online_code = create(:online_code, reward: reward_online)
    admin = create(:admin_user)
    login_as admin, scope: :admin_user
    visit admin_online_codes_path
    expect(page).to have_content online_code.code
    click_link 'Destroy'
    expect(page).to have_content 'Online code was successfully destroyed.'
    expect(page).not_to have_content online_code.code
  end

  it 'imports a csv file' do
    admin = create(:admin_user)
    login_as admin, scope: :admin_user
    create(:reward, title: 'onion', slug: 'onion')
    visit admin_online_codes_path
    click_button 'Import CSV file'
    expect(page).to have_content 'No file selected.'

    attach_file 'file', 'spec/factories/online_codes.rb'
    click_button 'Import CSV file'
    expect(page).to have_content 'File is not a ".csv"'

    attach_file 'file', 'spec/files/docs/online_codes_external_data.csv'
    click_button 'Import CSV file'
    visit admin_online_codes_path
    expect(page).to have_content '7986876'
  end
end
