# frozen_string_literal: true

class KudoPolicy < ApplicationPolicy
  def initialize(user, kudo)
    @user = user
    @kudo = kudo
  end

  def edit?
    @kudo.created_at > 5.minutes.ago && @kudo.employee == @user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
