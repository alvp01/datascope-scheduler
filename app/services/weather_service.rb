class WeatherService
  include HTTParty
  base_uri "https://api.openweathermap.org/data/2.5"
  attr_reader :location

  def initialize(location)
    @location = location
    @api_key = ENV["OPENWEATHER_API"]
  end

  def call
    location_array = @location.split(" ")
    response = self.class.get("/weather", query: { lat: location_array[0].split(":")[1], lon: location_array[1].split(":")[1], appid: @api_key })
    if response.success?
      parse_weather(response)
    else
      raise StandardError, "Unable to fetch weather: #{response.message}"
    end
  end

  private

  def parse_weather(response)
    {
      description: response["weather"].first["description"]
    }
  end
end
