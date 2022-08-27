# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include AuthConcern
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_auth unless Rails.env.test?

    private

    def user_not_auth
      flash[:alert] = t('.not_auth')
      redirect_to root_path
    end
  end
end
