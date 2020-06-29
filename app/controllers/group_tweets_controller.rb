class GroupTweetsController < ApplicationController
  before_action :set_group, :only => [:index, :create, :show, :new, :confirm]
  before_action :set_group_tweet, only: [:show, :destroy, :update]
  before_action :set_edit_group, only: [:edit]

  def index
    @group_tweets = @group.group_tweets.published.order("created_at DESC")
    @users =  User.all
  end

  def new
    @group_tweet = GroupTweet.new
    @group_tweets = @group.group_tweets.includes(:user)
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


  def show
    @group_tweet = GroupTweet.find(params[:id])
    if  @group_tweet.nil?
      redirect_to root_path
    elsif @group_tweet.draft?
      login_required
    end
    @group_tweets = @group.group_tweets.includes(:user)
    @users = User.all
    @opinion = Opinion.new
    @opinions = @group_tweet.opinions.includes(:user)
  end

  def edit
    @group = Group.all
  end

  def update
    @group_tweet.update(group_tweet_params)
  end

  def search
    @group_tweets = GroupTweet.search(params[:keyword])
    @users = User.all
  end

  def destroy
    @group_tweet.destroy
    redirect_to root_path
  end

  def confirm
    @group_tweets = @group.group_tweets.draft.order("created_at DESC")
    @users = User.all
    @group = Group.all
  end

  def login_required
    redirect_to login_url unless current_user
  end

  private

  def group_tweet_params
    params.require(:group_tweet).permit(:title, :image, :text, :status, :group_id).merge(user_id: current_user.id)
  end

  def set_group_tweet
    @group_tweet = GroupTweet.find(params[:id])
  end
  
  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_edit_group
    @group = Group.all
  end
end
