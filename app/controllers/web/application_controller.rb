# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include AuthConcern
    include AdminConcern
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_auth_or_not_admin unless Rails.env.test?

    private

    def user_not_auth_or_not_admin(exception)
      user = exception.policy.user
      if user.nil?
        flash[:alert] = t('not_auth')
      else
        flash[:aler] = t('not_admin')
      end
      redirect_to root_path
    end
  end
end
