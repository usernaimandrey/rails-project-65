# frozen_string_literal: true

module Web
  class Admin::CategoriesController < Admin::ApplicationController
    after_action :verify_authorized, only: :destroy

    def index
      @categories = Category.all.order(created_at: :asc)
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)

      if @category.save
        redirect_to admin_categories_path, notice: t('.success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @category = Category.find(params[:id])
    end

    def update
      @category = Category.find(params[:id])

      if @category.update(category_params)
        redirect_to admin_categories_path, notice: t('.success')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @category = Category.find(params[:id])
      authorize([:admin, @category])

      if @category.destroy
        redirect_to admin_categories_path, notice: t('.success')
      else
        flash[:alert] = t('.failure')
        redirect_to admin_categories_path
      end
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
