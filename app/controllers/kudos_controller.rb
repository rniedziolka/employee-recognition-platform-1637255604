# frozen_string_literal: true

class KudosController < ApplicationController
  def index
    render :index, locals: { kudos: Kudo.includes(:company_value, :employee, :receiver) }
  end

  def show
    render :show, locals: { kudo: kudo }
  end

  def new
    if current_employee.number_of_available_kudos < 1
      redirect_to kudos_path, notice: 'You do not have enough kudos to give away.'
    else
      render :new, locals: { kudo: Kudo.new }
    end
  end

  def edit
    authorize kudo
    render :edit, locals: { kudo: kudo }
  end

  def create
    if current_employee.number_of_available_kudos >= 1
      kudo = current_employee.given_kudos.build(kudo_params)
      if kudo.employee == current_employee && kudo.update(kudo_params)
        kudo.save
        current_employee.number_of_available_kudos -= 1
        current_employee.save
        redirect_to kudos_path, notice: 'Kudo was successfully  created. You have 5 min for making changes or deletion.'
      else
        render :new, locals: { kudo: kudo }
      end
    else
      redirect_to kudos_path, notice: 'You do not have enough kudos to give away.'
    end
  end

  def update
    authorize kudo
    if kudo.update(kudo_params)
      redirect_to kudos_path, notice: 'Kudo was successfully updated.'
    else
      render :edit, locals: { kudo: kudo }
    end
  end

  def destroy
    authorize kudo
    kudo.destroy
    redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'
  end

  private

  def kudo
    @kudo ||= Kudo.find(params[:id])
  end

  def kudo_params
    params.require(:kudo).permit(:title, :content, :employee_id, :receiver_id, :company_value_id)
  end
end
