class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @tweets = @user.tweets
    @image = @user.image
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :introduce, :nickname, :image )
  end
end
