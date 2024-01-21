class Weather
  attr_reader :client

  def self.by_city(city:)
    data = Net::HTTP.get(URI("https://api.openweathermap.org/data/2.5/forecast?q=#{city}&appid=#{Rails.application.credentials.openweather_key}&units=metric"))
    { searches: 
      {
        id: SecureRandom.uuid,
        city:,
        data: JSON.parse(data)
      }
    }
  end

  def self.by_coordinates(lat:, lon:)
    data = Net::HTTP.get(URI("https://api.openweathermap.org/data/2.5/forecast?lat=#{lat}&lon=#{lon}&appid=#{Rails.application.credentials.openweather_key}&units=metric"))
    { searches: 
      {
        id: SecureRandom.uuid,
        city: "Current location",
        data: JSON.parse(data)
      }
    }
  end
end