# frozen_string_literal: true

module Web
  class Admin::HomeController < Admin::ApplicationController
    def index
      authorize(%i[admin home])
    end
  end
end
