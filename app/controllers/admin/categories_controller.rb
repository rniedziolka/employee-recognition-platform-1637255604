# frozen_string_literal: true

module Admin
  class CategoriesController < AdminController
    def index
      render :index, locals: { categories: Category.all }
    end

    def show
      render :show, locals: { category: category }
    end

    def new
      render :new, locals: { category: Category.new }
    end

    def edit
      render :edit, locals: { category: category }
    end

    def create
      category = Category.new(category_params)
      if category.save
        redirect_to admin_categories_path(category), notice: 'Category was successfully created.'
      else
        render :new, locals: { category: category }
      end
    end

    def update
      if category.update(category_params)
        redirect_to admin_categories_path(category), notice: 'Category was successfully updated.'
      else
        render :edit, locals: { category: category }
      end
    end

    def destroy
      if category.destroy
        notice = 'Category was successfully destroyed.'
      else
        notice = 'The category cannot be deleted. It is assigned to the reward.'
      end
      redirect_to admin_categories_url, notice: notice
    end

    private

    def category
      @category ||= Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title)
    end
  end
end
