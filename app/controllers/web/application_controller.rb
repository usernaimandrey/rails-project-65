# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include AuthConcern
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_author
    def authenticate_user!
      return if signed_in?

      flash[:aler] = t('.forbidden')
      redirect_to root_path
    end

    private

    def user_not_author(exception)
      policy_name = exception.policy.class.to_s.underscore
      flash[:alert] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default

      redirect_to root_path
    end
  end
end
