class FavoritesController < ApplicationController
  before_action :set_tweet
  def create
    Favorite.create(user_id: current_user.id, tweet_id: params[:id])
    redirect_to tweets_path
  end

  def destroy
    Favorite.find_by(user_id: current_user.id, tweet_id: params[:id]).destroy
    redirect_to tweets_path
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
