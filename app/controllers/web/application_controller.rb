# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include AuthConcern
    include AdminConcern
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_auth_or_not_admin

    private

    def user_not_auth_or_not_admin(exception)
      user = exception&.policy&.user
      policy_name = exception.policy.class.to_s.underscore
      flash[:alert] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
      if user&.admin
        redirect_to current_page
      else
        redirect_to root_path
      end
    end
  end
end
