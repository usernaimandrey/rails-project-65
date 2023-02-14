# frozen_string_literal: true

class Web::Bulletins::FavoritesController < Web::Bulletins::ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    current_user.favorites.find_or_create_by(bulletin_id: params[:bulletin_id])

    redirect_to root_path
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id])

    favorite&.destroy
    redirect_to root_path
  end
end
