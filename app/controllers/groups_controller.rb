class GroupsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_group

  def index
    @groups = Group.all
    @group = Group.where(params[:id])
  end

  def show
    @group = Group.find(params[:id])
    if GroupUser.where(:user_id => current_user.id, :group_id => @group.id).present?
      @tweets = @group.tweets
      @tweet = Tweet.new
      @group_users = @group.group_users
    else
      redirect_back(fallback_location: root_path)
    end
    if !@group.users.include?(current_user)
      @group.users << current_user
    end

    @tweets = Tweet.where(group_id: @group.id).all
  end


  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_path(@group), notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group), notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

  def tweet_params
  params.require(:tweet).permit(:title, :image, :text, :gruop_id).merge(user_id: current_user.id)
  end

  # def set_group
  #   @group = Group.find(params[:group_id])
  # end
end
