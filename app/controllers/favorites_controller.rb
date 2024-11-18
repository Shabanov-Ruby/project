class FavoritesController < ApplicationController
  def index
    @favorites = get_favorites_from_storage
    response.headers['Cache-Control'] = 'public, max-age=3600'
    render json: @favorites
  end

  private

  def get_favorites_from_storage
    []
  end
end


