class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show, :destroy, :update]
  before_action :move_to_index, except: [:index, :show, :search]
  before_action :authenticate_user!, only: [:create]
  
  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
  end

  def new
    @tweet = Tweet.new
    @tweet = Tweet.create(tweet_params)
    @group = Group.find_by(id: params[:group_id])
  end

  def create
    Tweet.create(tweet_params)
    redirect_to root_path
    @group = Group.find_by(id: params[:group_id])
    # @tweet.group_id = params[:group_id]
    # i GroupUser.where(:user_id => current_user.id, :group_id => params[:tweet][:group_id]).present?
    #   @tweet = Tweet.create(params.require(:tweet).permit(:user_id, :content, :image, :group_id).merge(:user_id => current_user.id))
    #   redirect_to "/groups/#{@tweet.group_id}"
    # end
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
  end


  def search
    @tweets = Tweet.search(params[:keyword])
  end

  private
  def tweet_params
    params.require(:tweet).permit(:title, :image, :text, :gruop_id).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
  # def set_group
  #   @group = Group.find(params[:group_id])
  # end