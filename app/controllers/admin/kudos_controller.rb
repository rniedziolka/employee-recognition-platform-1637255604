# frozen_string_literal: true

module Admin
  class KudosController < AdminController
    def index
      @kudos = Kudo.all
    end

    def show
      @kudo = Kudo.find(params[:id])
    end

    def new
      @kudo = Kudo.new
    end

    def edit
      @kudo = Kudo.find(params[:id])
    end

    def create
      @kudo = Kudo.new(kudo_params)
      if @kudo.save
        redirect_to admin_kudos_path(@kudo), notice: 'Kudo was successfully created.'
      else
        render :new
      end
    end

    def update
      @kudo = Kudo.find(params[:id])
      if @kudo.update(kudo_params)
        redirect_to admin_kudos_path(@kudo), notice: 'Kudo was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @kudo = Kudo.find(params[:id])
      @kudo.destroy
      redirect_to admin_kudos_url, notice: 'Kudo was successfully destroyed.'
    end

    private

    def kudo_params
      params.require(:kudo).permit(:title, :content, :employee_id, :receiver_id)
    end
  end
end
