class Api::V1::EventsController < ApplicationController
  def index
    @events = Event.all.chronological

    render json: { events: EventSerializer.new(@events), status: :ok }
  end

  def create
    begin

      @user = User.find(params[:user_id])

      @event = CreateEventService.new(event_params[:location], event_params[:start_time], event_params[:end_time], event_params[:is_physical_location], @user).call
      @weather = @event.is_physical_location ? WeatherService.new(@event.location).call : nil
      EventMailer.event_created(@event, @user, @weather).deliver_now
      render json: { event: EventSerializer.new(@event), weather: @weather }, status: :created
    rescue StandardError => e
      render json: { error: e }, status: :bad_request
    end
  end

  private

  def event_params
    params.require(:event).permit(:location, :start_time, :end_time, :is_physical_location)
  end
end
