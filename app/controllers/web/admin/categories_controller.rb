# frozen_string_literal: true

module Web
  class Admin::CategoriesController < Admin::ApplicationController
    after_action :verify_authorized, only: %i[index new create edit update destroy]

    def index
      @categories = Category.all.order(created_at: :asc)
      authorize([:admin, @categories])
    end

    def new
      authorize([:admin, Category])
      @category = Category.new
    end

    def create
      authorize([:admin, Category])
      @category = Category.new(category_params)

      if @category.save
        redirect_to admin_categories_path, notice: t('.success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @category = Category.find(params[:id])
      authorize([:admin, @category])
    end

    def update
      @category = Category.find(params[:id])
      authorize([:admin, @category])

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
