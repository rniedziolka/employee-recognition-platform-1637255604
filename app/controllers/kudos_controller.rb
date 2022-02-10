# frozen_string_literal: true

class KudosController < ApplicationController
  def index
    @kudos = Kudo.all
  end

  def show
    @kudo = Kudo.find(params[:id])
  end

  def new
    @kudo = current_employee.given_kudos.build
  end

  def edit
    @kudo = Kudo.find(params[:id])
    if @kudo.employee == current_employee
      render :edit
    else
      redirect_to kudos_path, notice: 'You are not authorized to edit this kudo.'
    end
  end

  def create
    @kudo = current_employee.given_kudos.build(kudo_params)
    if @kudo.save
      redirect_to kudos_path, notice: 'Kudo was successfully created.'
    else
      render :new
    end
  end

  def update
    @kudo = Kudo.find(params[:id])
    if @kudo.employee == current_employee
      if @kudo.update(kudo_params)
        redirect_to kudos_path, notice: 'Kudo was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to kudos_path, notice: 'You are not authorized to edit this kudo.'
    end
  end

  def destroy
    @kudo = Kudo.find(params[:id])
    if @kudo.employee == current_employee
      @kudo.destroy
      redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'
    else
      redirect_to kudos_path, notice: 'You are not authorized to edit this kudo.'
    end
  end

  private

  def kudo_params
    params.require(:kudo).permit(:title, :content, :employee_id, :receiver_id, :company_value_id)
  end
end
