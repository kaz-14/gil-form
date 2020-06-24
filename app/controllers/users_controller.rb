class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @tweets = @user.tweets
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

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :introduce, :nickname, :image )
  end
end
