class Kudo < ApplicationRecord
    belongs_to :employee, optional: true
end
