# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      attributes = get_user_attributes(auth)
      user = User.find_or_initialize_by(attributes)

      if user.save
        sign_in(user)
        flash[:notice] = t('.success', name: attributes[:name].capitalize)
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
