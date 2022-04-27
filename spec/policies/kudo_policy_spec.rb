# frozen_string_literal: true

require 'rails_helper'

describe KudoPolicy do
  let(:employee) { create(:employee) }
  let(:employee_wrong) { create(:employee) }
  let(:kudo) { create(:kudo, employee: employee) }

  permissions :edit?, :update? do
    context 'when employee is kudo giver' do
      it 'grants access if kudo is less then 5 minutes old' do
        expect(described_class).to permit(employee, kudo)
      end

      it 'denies access if kudo is over 5 minute old' do
        kudo_old = create(:kudo, employee: employee)
        travel 6.minutes do
          expect(described_class).not_to permit(employee, kudo_old)
        end
      end
    end

    context 'when employee is not kudo giver' do
      it 'denies access' do
        expect(described_class).not_to permit(employee_wrong, kudo)
      end
    end
  end
end
