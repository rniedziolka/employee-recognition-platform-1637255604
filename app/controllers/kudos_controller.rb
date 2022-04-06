# frozen_string_literal: true

class KudosController < ApplicationController
  def index
    render :index, locals: { kudos: Kudo.includes(:company_value, :employee, :receiver).all }
  end

  def show
    render :show, locals: { kudo: kudo }
  end

  def new
    render :new, locals: { kudo: Kudo.new }
  end

  def edit
    if kudo.employee == current_employee
      render :edit, locals: { kudo: kudo }
    else
      redirect_to kudos_path, notice: 'You are not authorized to edit this kudo.'
    end
  end

  def create
    kudo = current_employee.given_kudos.build(kudo_params)
    if kudo.employee == current_employee
      kudo.save
      redirect_to kudos_path, notice: 'Kudo was successfully created.'
    else
      render :new, locals: { kudo: kudo }
    end
  end

  def update
    if kudo.employee == current_employee
      if kudo.update(kudo_params)
        redirect_to kudos_path, notice: 'Kudo was successfully updated.'
      else
        render :edit, locals: { kudo: kudo }
      end
    else
      redirect_to kudos_path, notice: 'You are not authorized to edit this kudo.'
    end
  end

  def destroy
    if kudo.employee == current_employee
      kudo.destroy
      redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'
    else
      redirect_to kudos_path, notice: 'You are not authorized to edit this kudo.'
    end
  end

  private

  def kudo
    @kudo ||= Kudo.find(params[:id])
  end

  def kudo_params
    params.require(:kudo).permit(:title, :content, :employee_id, :receiver_id, :company_value_id)
  end
end
