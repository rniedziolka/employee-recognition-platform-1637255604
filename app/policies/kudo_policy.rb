# frozen_string_literal: true

class KudoPolicy < ApplicationPolicy
  def edit?
    Time.zone.now - record.created_at < 5.minutes
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
