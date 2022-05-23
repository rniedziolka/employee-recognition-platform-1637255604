# frozen_string_literal: true

require 'csv'

module Export
  class OrderExport
    def initialize(data)
      @data = data
    end

    def to_csv
      attributes = %w[order_title order_description employee_email transaction_price created_at updated_at status]

      CSV.generate(headers: true) do |csv|
        csv << attributes

        @data.all.find_each do |order|
          csv << attributes.map { |attr| order.send(attr) }
        end
      end
    end
  end
end
