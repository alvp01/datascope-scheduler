class Api::V1::EventsController < ApplicationController
  def index
    @events = Event.all.chronological

    render json: @events, status: :ok
  end
end
