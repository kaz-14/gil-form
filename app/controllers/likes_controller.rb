class LikesController < ApplicationController
  before_action :set_group_tweet, only: [:destroy]
  before_action :set_group
  def create
    Like.create(user_id: current_user.id, group_tweet_id: params[:id])
    redirect_to group_group_tweets_path(@group.id)
  end

  def destroy
    Like.find_by(user_id: current_user.id, group_tweet_id: params[:id]).destroy
    redirect_to group_group_tweets_path(@group.id)
  end

  private
  def set_group_tweet
    @group_tweet = GroupTweet.find_by(params[:group_tweet_id])
  end

  def set_group
    @group = Group.find_by(params[:group_id])
  end
  
end
