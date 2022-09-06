# frozen_string_literal: true

module Web
  class Admin::ApplicationController < ApplicationController
    before_action :authenticate_admin!

    rescue_from Pundit::NotAuthorizedError, with: :category_has_relation

    def authenticate_admin!
      return if admin_signed_in?

      flash[:alert] = t('.forbidden')
      redirect_to root_path
    end

    private

    def category_has_relation
      flash[:alert] = t('.has_relations')

      redirect_to url_for(action: 'index')
    end
  end
end
