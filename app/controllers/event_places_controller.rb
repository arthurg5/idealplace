class EventPlacesController < ApplicationController
  before_action :set_event, only: [:new, :create, :index]
  before_action :set_event_place, only: [:show, :vote]

  def new
    @event_place = @event.event_places.new
  end

  def create
    @place = Place.find(params[:place_id])
    @event_place = EventPlace.new(event: @event, place: @place)
    if @event_place.save
      respond_to do |format|
        format.html { redirect_to event_path(@event) }
        format.text { render partial: "shared/filtered_places", formats: :html, locals: { event: @event, places: Place.all } }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @event_places = @event.event_places
    @places = @event_places.map { |event_place| event_place.place }

    # TODO get places with active record query, and ad geocoded below

    @geomarkers = @places.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        info_window_html: render_to_string(partial: "event_places/info_window4", locals: { place: place }, formats: :html),
        marker_html: render_to_string(partial: "event_places/marker4", locals: { place: place }, formats: :html)
      }
    end
    voted_by_all_users
    send_notif
  end

  def show
  end

  def vote
    current_user.favorite(@event_place) unless @event_place.event.voted_by_user(current_user)
    redirect_to event_event_places_path(@event_place.event)
  end

  def voted_by_all_users
    @vote_count = 0
    @vote_count_event_place = 0
    @event.event_places.each do |event_place|
      @vote_count_event_place = event_place.favoritors.count
    end
    @event.event_places.each do |event_place|
      @vote_count = event_place.favoritors.count
      if @vote_count == @event.group.users.count
        event_place.selected = true
        @event.status = "Voted"
        @event.save
      end
    end
  end


  def send_notif
    # check if the current user has voted on an event place of an event he created
    # if current_user.all_favorites && current_user == @event.user
    #   # get all the users of the group of that event
    #   group_users = @event.group.users
    #   # loop through each user and create a notification for them
    #   group_users.each do |user|
    #     # skip the current user
    #     next if user == current_user
    #     # create a notification with a message and a link to the event
    #     notification = Notification.new(user: user, message: "#{current_user.name} has voted on an event place for #{event.name}. Check it out here:", link: event_event_places_path(@event))
    #     # save the notification
    #     notification.save
    #   end
    # end
  end




  def destroy
    @event_places.delete(event_place)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_place
    @event_place = EventPlace.find(params[:id])
  end

  def event_place_params
    params.require(:event_place).permit(:event_id, :place_id)
  end
end
