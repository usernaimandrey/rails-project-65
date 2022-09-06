# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      user = auth_user(auth)

      if user.persisted?
        sign_in(user)
        flash[:notice] = t('.success', name: auth.info.name)
      else
        flash[:alert] = t('.failure')
      end
      redirect_to root_path
    end

    private

    def auth
      request.env['omniauth.auth']
    end
  end
end
