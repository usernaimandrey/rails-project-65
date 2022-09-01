# frozen_string_literal: true

module Web
  class Admin::BulletinsController < Admin::ApplicationController
    after_action :verify_authorized, only: %i[index destroy archive publish]

    def index
      @search_bulletins = Bulletin.ransack(params[:search_bulletins])
      @bulletins = @search_bulletins.result.order(created_at: :desc)
      authorize([:admin, @bulletins])
    end

    def destroy
      @bulletin = Bulletin.find(params[:id])
      authorize([:admin, @bulletin])

      @bulletin.image.purge
      @bulletin.destroy
      redirect_to admin_bulletins_path, notice: t('.success')
    end

    def archive
      @bulletin = Bulletin.find(params[:id])
      authorize([:admin, @bulletin])

      if @bulletin.archive!
        flash[:notice] = t('.success')
        redirect_to current_page
      else
        flash[:alert] = t('.failure', state: @bulletin.aasm.human_state)
        redirect_to current_page, status: :unprocessable_entity
      end
    end

    def publish
      @bulletin = Bulletin.find(params[:id])
      authorize([:admin, @bulletin])

      if @bulletin.publish!
        flash[:notice] = t('.success')
        redirect_to current_page
      else
        flash[:alert] = t('.failure', state: @bulletin.aasm.human_state)
        redirect_to current_page, status: :unprocessable_entity
      end
    end

    def reject
      @bulletin = Bulletin.find(params[:id])
      authorize([:admin, @bulletin])

      if @bulletin.reject!
        flash[:notice] = t('.success')
        redirect_to current_page
      else
        flash[:alert] = t('.failure', state: @bulletin.aasm.human_state)
        redirect_to current_page, status: :unprocessable_entity
      end
    end
  end
end
