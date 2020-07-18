class CommentsController < ApplicationController
  before_action :set_tweet

  def create
    @comment = Comment.create(comment_params)
    respond_to do |format|
      format.html { redirect_to tweet_path(params[:tweet_id])  }
      format.json
    end
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def get_all_comments
    @comments = @tweet.comments.includes(:user).order('created_at asc')
  end


  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end
