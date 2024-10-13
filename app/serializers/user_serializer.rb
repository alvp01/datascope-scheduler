class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email

  attribute :events do |object|
    object.events.map { |event| EventSerializer.new(event) }
  end
end
