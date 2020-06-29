class OpinionsController < ApplicationController
  def create
    opinion = Opinion.create(opinion_params)
    redirect_to group_group_tweet_path(opinion.group_tweet.id)
  end

  private
  def opinion_params
    params.require(:opinion).permit(:text).merge(user_id: current_user.id, group_tweet_id: params[:group_tweet_id])
  end
end
