class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @events = Event.all

    # if params[:query]
    #   @events = Event.search_events(params[:query])
    # end
  end

  def show
    @event = Event.find(params[:id])
    @selected_group_name = @event.selected_group_name || "No group"

    @event_name = @event.name
    @event_places = @event.event_places
    @places = Place.all
    @group_users = @event.group.users

    # Check for category filtering
    @places = Place.where(category: params[:category]) if params[:category].present?

    @markers = @places.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        info_window_html: render_to_string(partial: "info_window1", locals: { place: place }),
        marker_html: render_to_string(partial: "marker1", locals: { place: place })
      }
    end

    @markers_group_users = @group_users.geocoded.map do |group_user|
      {
        lat: group_user.latitude, # default latitude
        lng: group_user.longitude, # default longitude
        info_window_html: render_to_string(partial: "info_window2", locals: { group_user: group_user }),
        marker_html: render_to_string(partial: "marker2", locals: { group_user: group_user })
      }
    end

    # On aun array de hash avec plein de clés dont lat: lng:
    # on va mapper sur l'array, on va être sur chaque hash
    # on va return à chaque fois un array avec la clé correspondante

    @barycenter = @markers_group_users
    @barycenter = @barycenter.map do |marker|
      [marker[:lat], marker[:lng]]
    end

    @barycenter = Geocoder::Calculations.geographic_center(@barycenter)
    @barycenter_marker = {
      lat: @barycenter[0],
      lng: @barycenter[1],
      info_window_html: "barycenter",
      marker_html: render_to_string(partial: "marker2")
    }


    @markers = @markers.concat(@markers_group_users).push(@barycenter_marker)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @event = Event.new
    @event.name = params[:name] # Set the name attribute from the form parameters
    @groups = Group.all
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    selected_group_name = params[:event][:selected_group_name]
    group = Group.find_by(name: selected_group_name)

    if group

      @event.group = group
      @event.group_id = group.id # Assign the group_id explicitly
    else
      # Handle the scenario where the group does not exist
      # You can add code here to create a new group or handle the error as required
    end

    if @event.save
      redirect_to event_path(@event)
    else
      @groups = Group.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to event_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :start_time, :selected_group_name)
  end
end
