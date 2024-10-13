class Api::V1::EventsController < ApplicationController
  def index
    @events = Event.all.chronological

    render json: { events: EventSerializer.new(@events), status: :ok }
  end

  def create
    begin

      user = User.find(params[:user_id])

      @event = CreateEventService.new(event_params[:location], event_params[:start_time], event_params[:end_time], user).call
      render json: { event: EventSerializer.new(@event), status: :created }
    rescue StandardError => e
      render json: { error: e }, status: :bad_request
    end
  end

  private

  def event_params
    params.require(:event).permit(:location, :start_time, :end_time)
  end
end
