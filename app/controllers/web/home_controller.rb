# frozen_string_literal: true

module Web
  class HomeController < ApplicationController
    def index
      @bullentins = Bulletin.all.order(created_at: :desc)
    end
  end
end
