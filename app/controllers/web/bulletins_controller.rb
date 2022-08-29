# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    after_action :verify_authorized, only: %i[new create]

    def index
      @bulletins = Bulletin.all.order(created_at: :desc)
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def new
      authorize Bulletin
      @bulletin = Bulletin.new
    end

    def create
      authorize Bulletin
      @bulletin = current_user&.bulletins&.build(bulletin_params)

      if @bulletin.save
        redirect_to root_path, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @bulletin = current_user&.bulletins&.find(params[:id])
      authorize @bulletin
    end

    def update
      @bulletin = current_user&.bulletins&.find(params[:id])
      authorize @bulletin

      if @bulletin.update(bulletin_params)
        redirect_to @bulletin, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
