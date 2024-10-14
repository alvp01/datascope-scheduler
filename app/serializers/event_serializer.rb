class EventSerializer
  include JSONAPI::Serializer
  attribute :location

  attribute :start_time do |event|
    event.start_time.strftime("%A, %B %d, %Y at %I:%M %p")
  end

  attribute :end_time do |event|
    event.end_time.strftime("%A, %B %d, %Y at %I:%M %p")
  end
end
