class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    # @event_places = current_user.event_places
    # @events = current_user.events
    @groups = current_user.groups
    @group = Group.new

    # @groups_user.id = @group.id
    # @group.id = current_user.groups
  end
end
