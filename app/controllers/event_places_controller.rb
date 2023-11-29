class EventPlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  before_action :set_event, only: [:new, :create]
  before_action :set_event_place, only: [:show, :vote]

  def new
    @event_place = EventPlace.new
  end

  def create
    @event_place = EventPlace.new(event_place_params)
    @event_place.event = @event
    @event_place.place = Place.find(params[:place_id])
    if @event_place.save
      redirect_to event_place_path(@event_place)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @event_places = EventPlace.all
  end

  def show
  end

  def vote
    current_user.favorite(@event_place)
    redirect_to event_place_path(@event_place)
    event_place_1_count = 0
    @event_place.event.event_places.each do |current_event_place|
      if current_event_place == current_user.all_favorites
        event_place_1_count += 1
      end
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_place
    @event_place = EventPlace.find(params[:id])
  end

  def event_place_params
    params.require(:event_place).permit(:duration, :distance, :transport_mode)
  end
end
