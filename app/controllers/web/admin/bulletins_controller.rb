# frozen_string_literal: true

module Web
  class Admin::BulletinsController < Admin::ApplicationController
    def index
      @search_bulletins = Bulletin.ransack(params[:search_bulletins])
      @bulletins = @search_bulletins
                   .result.order(created_at: :desc)
                   .page(params[:page])
    end

    def destroy
      @bulletin = Bulletin.find(params[:id])

      # @bulletin.image.purge
      @bulletin.destroy
      redirect_to admin_bulletins_path, notice: t('.success')
    end

    def archive
      @bulletin = Bulletin.find(params[:id])

      if @bulletin.archive!
        flash[:notice] = t('.success')
        redirect_to url_for(action: 'index')
      else
        flash[:alert] = t('.failure', state: @bulletin.aasm.human_state)
        redirect_to url_for(action: 'index'), status: :unprocessable_entity
      end
    end

    def publish
      @bulletin = Bulletin.find(params[:id])

      if @bulletin.publish!
        flash[:notice] = t('.success')
        redirect_to url_for(action: 'index')
      else
        flash[:alert] = t('.failure', state: @bulletin.aasm.human_state)
        redirect_to url_for(action: 'index'), status: :unprocessable_entity
      end
    end

    def reject
      @bulletin = Bulletin.find(params[:id])

      if @bulletin.reject!
        flash[:notice] = t('.success')
        redirect_to url_for(action: 'index')
      else
        flash[:alert] = t('.failure', state: @bulletin.aasm.human_state)
        redirect_to url_for(action: 'index'), status: :unprocessable_entity
      end
    end
  end
end
