class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @events = Event.all

    # if params[:query]
    #   @events = Event.search_events(params[:query])
    # end

    # @markers = @events.geocoded.map do |event|
    #   {
    #     lat: event.latitude,
    #     lng: event.longitude,
    #     info_window_html: render_to_string(partial: "info_window", locals: { event: event }),
    #     marker_html: render_to_string(partial: "marker")
    #   }
    # end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event)
    else
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
    params.require(:event).permit(:name, :date, :start_time)
  end

end
