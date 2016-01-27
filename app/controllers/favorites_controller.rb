class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    @micropost = Micropost.find_by(id: params[:micropost_id])
    current_user.favorite(@micropost)
    @favorites_count = current_user.favorites.count
  end
  
  def destroy
    @micropost = Micropost.find_by(id: params[:id])
    current_user.unfavorite(@micropost)
    @favorites_count = current_user.favorites.count
  end
end
