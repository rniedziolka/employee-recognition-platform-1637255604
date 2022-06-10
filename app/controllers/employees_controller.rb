# frozen_string_literal: true

class EmployeesController < ApplicationController
  def edit
    render :edit, locals: { employee: current_employee }
  end

  def update
    if employee.update(employee_params)
      notice = 'Your name was successfully added.'
    else
      notice = 'First name and last name cannot be empty.'
    end
    redirect_to root_path, notice: notice
  end

  private

  def employee
    @employee ||= Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :password, :number_of_available_kudos)
  end
end
