# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:employee) { create(:employee) }
  let!(:reward) { create(:reward, price: 1) }
  let!(:kudo) { create(:kudo, receiver: employee) }

  it 'orders test' do
    sign_in(employee)

    visit root_path

    click_link 'Rewards'
    click_link 'Buy'
    expect(page).to have_content reward.title
    click_button 'Buy'
    click_link 'Orders'

    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward.price
  end
end
