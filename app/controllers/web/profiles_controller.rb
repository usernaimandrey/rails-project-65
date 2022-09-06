# frozen_string_literal: true

module Web
  class ProfilesController < ApplicationController
    before_action :authenticate_user!, only: :show

    def show
      @search_bulletins = current_user&.bulletins&.ransack(params[:search_bulletins])
      @bulletins = @search_bulletins
                   &.result
                   &.order(created_at: :desc)
                   &.page(params[:page])
    end
  end
end
