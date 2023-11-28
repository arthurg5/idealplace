class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
    # @group_user.group = @group.id
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      # If you want to associate users based on the form input (group_users)
      params[:group][:group_users].each do |user_id|
        @group.group_users.create(user_id: user_id) unless user_id.blank?
      end

      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
