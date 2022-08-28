# frozen_string_literal: true

module Web
  class Admin::BulletinsController < Admin::ApplicationController
    def index
      @bulletins = Bulletin.all.order(created_at: :desc)
      authorize([:admin, @bulletins], :index)
    end
  end
end
