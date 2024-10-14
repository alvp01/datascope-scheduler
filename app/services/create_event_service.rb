class CreateEventService
  attr_reader :location, :start_time, :end_time, :user

  def initialize(location, start_time, end_time, is_physical_location, user)
    @location = location
    @start_time = start_time
    @end_time = end_time
    @is_physical_location = is_physical_location
    @user = user
  end

  def call
    overlaping_events = Event.where(user_id: user.id).where("(start_time, end_time) OVERLAPS (?, ?)", @start_time, @end_time)
    raise StandardError, "The event overlaps with other existing events" if overlaping_events.present?

    @user.events.create!(location: @location, start_time: @start_time, end_time: @end_time, is_physical_location: @is_physical_location)
  end
end
