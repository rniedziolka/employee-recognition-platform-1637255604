# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def pundit_user
    current_employee
  end

  private

  def user_not_authorized
    redirect_to kudos_path, notice: 'You are not authorized to perform this action.'
  end
end
