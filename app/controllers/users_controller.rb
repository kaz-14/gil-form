class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:show]

  def index
    @users = User.all
    return nil if params[:keyword] == ""
    @users = User.where(['nickname LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @users = User.all
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @tweets = @user.tweets.published.includes(:user).order("created_at DESC")
    @image = @user.image
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @user = user.followers
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :introduce, :nickname, :image )
  end
end
