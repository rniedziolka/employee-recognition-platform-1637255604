# frozen_string_literal: true

module Admin
  class CompanyValuesController < AdminController
    def index
      render :index, locals: { company_values: CompanyValue.all }
    end

    def show
      render :show, locals: { company_value: company_value }
    end

    def new
      render :new, locals: { company_value: CompanyValue.new }
    end

    def edit
      render :edit, locals: { company_value: company_value }
    end

    def create
      company_value = CompanyValue.new(company_value_params)
      if company_value.save
        redirect_to admin_company_values_path(company_value), notice: 'Company Value was successfully created.'
      else
        render :new, locals: { company_value: company_value }
      end
    end

    def update
      if company_value.update(company_value_params)
        redirect_to admin_company_values_path(company_value), notice: 'Company Value was successfully updated.'
      else
        render :edit, locals: { company_value: company_value }
      end
    end

    def destroy
      if company_value.destroy
        notice = 'Company Value was successfully destroyed.'
      else
        notice = 'The Company Value cannot be deleted. It is assigned to the Kudo.'
      end
      redirect_to admin_company_values_url, notice: notice
    end

    private

    def company_value
      @company_value ||= CompanyValue.find(params[:id])
    end

    def company_value_params
      params.require(:company_value).permit(:title)
    end
  end
end
