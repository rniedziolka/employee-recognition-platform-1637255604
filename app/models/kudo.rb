# frozen_string_literal: true

class Kudo < ApplicationRecord
  belongs_to :employee, optional: true
end
