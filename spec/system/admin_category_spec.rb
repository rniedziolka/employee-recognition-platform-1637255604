# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminCategory crud', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin_user) { create(:admin_user) }
  let(:category) { build(:category) }
  let!(:reward) { create(:reward) }

  it 'test admin crud actions' do
    login_as(admin_user)
    visit admin_root_path

    # create new category
    click_link 'Categories'
    click_link 'New Category'
    click_button 'Create Category'
    expect(page).to have_content 'Title can\'t be blank'
    fill_in 'category[title]', with: category.title
    click_button 'Create Category'
    expect(page).to have_content 'Category was successfully created.'
    expect(page).to have_content category.title

    # add category to reward
    click_link 'Rewards'
    click_link 'Edit'
    expect(page).to have_unchecked_field(category.title)
    check category.title
    click_button 'Update Reward'
    click_link 'Edit'
    expect(page).to have_checked_field(category.title)
  end
end
