class VotesController < ApplicationController
  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.user = current_user
    @vote.event_place = @event_place
    if @vote.save
      redirect_to event_place_path(@event_place)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :event_place_id)
  end
end
