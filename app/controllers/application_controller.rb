# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def pundit_user
    current_employee
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  private

  def user_not_authorized
    redirect_to kudos_path, notice: 'You are not authorized to perform this action.'
  end
end
