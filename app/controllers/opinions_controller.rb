class OpinionsController < ApplicationController
  def create
    opinion = Opinion.create(opinion_params)
    @group = Group.find(params[:group_id])
    respond_to do |format|
      format.html { redirect_to group_group_tweet_path(@group.id,opinion.group_tweet.id)  }
      format.json
    end
  end

  private
  def opinion_params
    params.require(:opinion).permit(:text).merge(user_id: current_user.id, group_tweet_id: params[:group_tweet_id])
  end
end
