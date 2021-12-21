# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'kudos/edit', type: :view do
  before do
    @kudo = assign(:kudo, Kudo.create!(
                            title: 'MyString',
                            content: 'MyText'
                          ))
  end

  it 'renders the edit kudo form' do
    render

    assert_select 'form[action=?][method=?]', kudo_path(@kudo), 'post' do
      assert_select 'input[name=?]', 'kudo[title]'

      assert_select 'textarea[name=?]', 'kudo[content]'
    end
  end
end
