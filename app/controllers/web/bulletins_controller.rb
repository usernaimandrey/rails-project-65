# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    after_action :verify_authorized, only: %i[new create edit update on_moderate archive]

    def index
      @bulletins = Bulletin.published.order(created_at: :desc)
    end

    def show
      @bulletin = set_bulletin
    end

    def new
      authorize Bulletin
      @bulletin = Bulletin.new
    end

    def create
      authorize Bulletin
      @bulletin = current_user&.bulletins&.build(bulletin_params)

      if @bulletin.save
        redirect_to profile_path, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :new, status: :unprocessable_entity
      end
    end

    def on_moderate
      @bulletin = set_bulletin
      authorize @bulletin

      if @bulletin.on_moderate!
        flash[:notice] = t('.success')
        redirect_to profile_path
      else
        flash[:alert] = t('.failure', state: @bulletin.aasm.human_state)
        redirect_to profile_path, status: :unprocessable_entity
      end
    end

    def archive
      @bulletin = set_bulletin
      authorize @bulletin

      if @bulletin.archive!
        flash[:notice] = t('.success')
        redirect_to profile_path
      else
        flash[:alert] = t('.failure', state: @bulletin.aasm.human_state)
        redirect_to profile_path, status: :unprocessable_entity
      end
    end

    def edit
      @bulletin = set_bulletin
      authorize @bulletin
    end

    def update
      @bulletin = set_bulletin
      authorize @bulletin

      if @bulletin.update(bulletin_params)
        redirect_to profile_path, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end

    def set_bulletin
      Bulletin.find(params[:id])
    end
  end
end
