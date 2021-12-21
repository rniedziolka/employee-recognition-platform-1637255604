# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'kudos/new', type: :view do
  before do
    assign(:kudo, Kudo.new(
                    title: 'MyString',
                    content: 'MyText'
                  ))
  end

  it 'renders new kudo form' do
    render

    assert_select 'form[action=?][method=?]', kudos_path, 'post' do
      assert_select 'input[name=?]', 'kudo[title]'

      assert_select 'textarea[name=?]', 'kudo[content]'
    end
  end
end
