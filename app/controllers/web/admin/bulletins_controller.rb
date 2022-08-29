# frozen_string_literal: true

module Web
  class Admin::BulletinsController < Admin::ApplicationController
    def index
      @bulletins = Bulletin.all.order(created_at: :desc)
      authorize([:admin, @bulletins])
    end

    def destroy
      @bulletin = Bulletin.find(params[:id])
      authorize([:admin, @bulletin])

      @bulletin.destroy
      redirect_to admin_bulletins_path, notice: t('.success')
    end
  end
end
