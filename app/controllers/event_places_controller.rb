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
      if @event.event_places.count >= 3
        redirect_to event_event_places_path
      else
        redirect_to event_path(@event)
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
        lng: place.longitude
      }
    end

  end

  def show
  end

  def vote
    current_user.favorite(@event_place) unless @event_place.event.voted_by_user(current_user)
    redirect_to event_event_places_path(@event_place.event)
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
