# frozen_string_literal: true

module Web
  class HomeController < ApplicationController
    def index
      @bulletins = Bulletin.published.order(created_at: :desc)
    end
  end
end
