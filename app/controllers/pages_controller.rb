class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @user = current_user
    @groups = Group.all
    @group = Group.new
    @events = Event.all

    @events = Event.where.not(status: 'Passed')
    @passed_events = Event.where(status: 'Passed')

  end
end
