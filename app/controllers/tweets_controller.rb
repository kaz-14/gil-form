class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show, :destroy, :update]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets = Tweet.published.order("created_at DESC")
    @users =  User.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
    redirect_to root_path
  end

  def destroy
    @tweet.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
    @tweet.update(tweet_params)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
    @tweet = Tweet.find_by(id: params[:id])
    if  @tweet.nil?
      redirect_to root_path
    elsif @tweet.draft?
      login_required
    end
    @users = User.all
  end


  def search
    @tweets = Tweet.search(params[:keyword])
    @users = User.all
  end

  def confirm
    @tweets = Tweet.draft.order("created_at DESC")
    @users = User.all
  end

  def login_required
    redirect_to login_url unless current_user
  end

  private
  def tweet_params
    params.require(:tweet).permit(:title, :image, :text, :status).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end