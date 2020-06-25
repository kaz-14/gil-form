class GroupTweetsController < ApplicationController
  before_action :set_group, :only => [:index, :create, :show, :new]
  before_action :set_group_tweet, only: [:show, :destroy, :update]

  def index
    @group_tweets = @group.group_tweets.includes(:user).order("created_at DESC")
  end

  def new
    @group_tweet = GroupTweet.new
    @group_tweets = @group.group_tweets.includes(:user)
  end

  def show
    @group_tweet = GroupTweet.find(params[:id])
    # @group_tweet = Group.find(params[:id])
    @group_tweets = @group.group_tweets.includes(:user)
  end

  def edit
  end

  def create
    @group_tweet = @group.group_tweets.new(group_tweet_params)
    if @group_tweet.save
      redirect_to group_group_tweets_path(@group)
    else
      @group_tweets = @group.group_tweet.includes(:user)
      # flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
    # if @group_tweet.save
    #   render :index
    #   # respond_to do |format|
    #   #   format.json
    #   # end
    # else
    #   render :index
    # end
  end

  def update
    @group_tweet.update(group_tweet_params)
  end

  def destroy
    @group_tweet.destroy
    redirect_to root_path
  end

  private

  def group_tweet_params
    params.require(:group_tweet).permit(:title, :image, :text, :group_id).merge(user_id: current_user.id)
  end

  def set_group_tweet
    @group_tweet = GroupTweet.find(params[:id])
  end
  
  def set_group
    @group = Group.find(params[:group_id])
  end
end
