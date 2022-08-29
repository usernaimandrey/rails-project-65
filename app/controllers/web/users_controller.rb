# frozen_string_literal: true

module Web
  class UsersController < ApplicationController
    after_action :verify_authorized, only: %i[show]

    def show
      @bulletins = current_user.bulletins.order(created_at: :desc)
      authorize(:user)
    end
  end
end
