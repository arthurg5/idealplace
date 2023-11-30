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

    @event_places = @event.event_places
    @markers = @event.places.geocoded.map do |place|

      {
        lat: place.latitude,
        lng: place.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { place: place }),
        # marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def new
    @event = Event.new
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
