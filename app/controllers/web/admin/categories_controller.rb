# frozen_string_literal: true

module Web
  class Admin::CategoriesController < Admin::ApplicationController
    def index
      @categories = Category.all.order(created_at: :asc)
      authorize([:admin, @categories], :index)
    end
  end
end
