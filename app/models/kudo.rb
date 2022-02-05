# frozen_string_literal: true

class Kudo < ApplicationRecord
  belongs_to :employee, class_name: 'Employee'
  belongs_to :receiver, class_name: 'Employee'

  validates :title, :content, presence: true
end
