# frozen_string_literal: true

class Kudo < ApplicationRecord
  belongs_to :employee, class_name: 'Employee'
  belongs_to :receiver, class_name: 'Employee'
  belongs_to :company_value

  validates :title, :content, :employee_id, :receiver_id, :company_value_id, presence: true
end
