class FavoritesController < ApplicationController

  def index
    @user = current_user
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def create
    @favorite = current_user.favorites.create(post_id: params[:post_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    #@favorite = Favorite.where(post_id: params[:post_id], user_id: params[:user_id]).first
    @favorite = Favorite.find_by(id: params[:id])
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end



end
