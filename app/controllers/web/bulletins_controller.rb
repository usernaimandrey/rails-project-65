# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :authenticate_user!, only: %i[new create edit update to_moderation archive]
    after_action :verify_authorized, only: %i[show edit update to_moderation archive]

    def index
      @search_bulletins = Bulletin.ransack(params[:search_bulletins])
      @bulletins = @search_bulletins
                   .result
                   .published.order(created_at: :desc)
                   .page(params[:page])
    end

    def show
      @bulletin = find_bulletin
      authorize @bulletin
    end

    def new
      @bulletin = current_user.bulletins.build
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)

      if @bulletin.save
        redirect_to profile_path, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :new, status: :unprocessable_entity
      end
    end

    def to_moderation
      @bulletin = find_bulletin
      authorize @bulletin

      if @bulletin.to_moderate!
        flash[:notice] = t('.success')
        redirect_to profile_path
      else
        flash[:alert] = t('.failure', state: @bulletin.aasm.human_state)
        redirect_to profile_path, status: :unprocessable_entity
      end
    end

    def archive
      @bulletin = find_bulletin
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
      @bulletin = find_bulletin
      authorize @bulletin
    end

    def update
      @bulletin = find_bulletin
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

    def find_bulletin
      Bulletin.find(params[:id])
    end
  end
end
