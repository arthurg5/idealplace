class GroupsController < ApplicationController
  skip_before_action :authenticate_user!, only: :dashboard

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
    @group_user.group = @group.id
  end

  def create
    
    @group.user = current_user
    @group = Group.new(group_params)
    if @group.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :user_id)
  end
end
