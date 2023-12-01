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

    # Check for category filtering
    @places = Place.where(category: params[:category]) if params[:category].present?

    @event_place = EventPlace.new(place: Place.find(14))

    @markers = @places.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { place: place }),
        marker_html: render_to_string(partial: "marker", locals: { place: place })
      }
    end

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
    @event.selected_group_name = params[:event][:selected_group_name]

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
