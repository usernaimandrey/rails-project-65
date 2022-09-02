# frozen_string_literal: true

module Web
  class UsersController < ApplicationController
    after_action :verify_authorized, only: %i[show]

    def show
      @search_bulletins = current_user&.bulletins&.ransack(params[:search_bulletins])
      @bulletins = @search_bulletins
                   &.result
                   &.order(created_at: :desc)
                   &.page(params[:page])
      authorize(:user)
    end
  end
end
