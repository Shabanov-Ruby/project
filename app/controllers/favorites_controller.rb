class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites
    response.headers['Cache-Control'] = 'public, max-age=3600' # Кэшировать на 1 час
    render json: @favorites
  end
end
