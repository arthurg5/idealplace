class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @user = current_user
    @groups = Group.all
    @group = Group.new
    @events = Event.all

    @my_created_events = Event.where(status: 'Created', user_id: current_user.id)
    @my_voted_events = Event.where(status: 'Voted', user_id: current_user.id)
    @my_passed_events = Event.where(status: 'Passed', user_id: current_user.id)

    @other_events = Event.where.not(user_id: current_user.id)
    @created_events = @other_events.where(status: 'Created')
    @voted_events = @other_events.where(status: 'Voted')
    @passed_events = @other_events.where(status: 'Passed')

  end
end
