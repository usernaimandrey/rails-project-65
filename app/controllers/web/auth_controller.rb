# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      email = auth[:info][:name].downcase
      name = auth[:info][:name]
      user = User.find_or_initialize_by(email: email, name: name)

      if user.save
        sign_in(user)
        flash[:notice] = t('.success', name: name)
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
