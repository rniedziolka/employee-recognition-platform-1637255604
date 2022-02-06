# frozen_string_literal: true

class KudosController < ApplicationController
  before_action :set_kudo, only: %i[show edit update destroy]
  before_action :authenticate_employee!, except: %i[index show]
  before_action :correct_employee, only: %i[edit update destroy]

  def index
    @kudos = Kudo.all
  end

  def show; end

  def new
    @kudo = current_employee.given_kudos.build
  end

  def edit; end

  def create
    @kudo = Kudo.new(kudo_params)
    @kudo = current_employee.given_kudos.build(kudo_params)
    if @kudo.save
      redirect_to kudos_path, notice: 'Kudo was successfully created.'
    else
      render :new
    end
  end

  def update
    if @kudo.update(kudo_params)
      redirect_to kudos_path, notice: 'Kudo was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @kudo.destroy
    redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'
  end

  def correct_employee
    @kudo = current_employee.given_kudos.find_by(id: params[:id])
    redirect_to kudos_path, notice: 'Not Authorized To Edit This Kudo' if @kudo.nil?
  end

  private

  def set_kudo
    @kudo = Kudo.find(params[:id])
  end

  def kudo_params
    params.require(:kudo).permit(:title, :content, :employee_id, :receiver_id)
  end
end
