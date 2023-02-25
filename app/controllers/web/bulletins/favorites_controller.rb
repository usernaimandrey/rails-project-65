# frozen_string_literal: true

class Web::Bulletins::FavoritesController < Web::Bulletins::ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  after_action :verify_authorized, only: %i[create]

  def create
    favorite = current_user.favorites.find_or_initialize_by(bulletin_id: params[:bulletin_id])
    authorize([:bulletins, favorite])
    favorite.save!

    redirect_to root_path
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id])

    favorite&.destroy
    redirect_to root_path
  end
end
