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
        redirect_to admin_categories_url, notice: 'Category was successfully destroyed.'
      else
        redirect_to admin_categories_url, notice: category.errors.full_messages[0]
      end
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
