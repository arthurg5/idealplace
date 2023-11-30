class EventPlacesController < ApplicationController
  before_action :set_event, only: [:new, :create, :index, :vote]
  before_action :set_event_place, only: [:show, :vote]

  def new
    @event_place = @event.event_places.new
  end

  def create
    @event_place = @event.event_places.new(event_place_params)
    @event_place.place = Place.find(params[:place_id])

    if @event_place.save
      redirect_to event_place_path(@event, @event_place)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @event_places = @event.event_places
  end

  def show
  end

  def vote
    raise
    current_user.favorite(@event_place)
    # event_place_1_count = 0
    # @event_place.event.event_places.each do |current_event_place|
    #   if current_event_place == current_user.all_favorites
    #     event_place_1_count += 1
    #   end
    # end
    redirect_to event_place_path(@event_place)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_place
    @event_place = @event.event_places.find(params[:id])
  end

  def event_place_params
    params.require(:event_place).permit(:duration, :distance, :transport_mode)
  end
end
