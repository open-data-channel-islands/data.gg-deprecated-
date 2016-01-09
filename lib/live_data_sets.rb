class LiveDataSets

  def self.get_flights_arrivals
    if Rails.cache.exist? 'arrivals'
      @flights = Rails.cache.fetch('arrivals')
    else
      @flights = FlightsParser::get_arrivals
      Rails.cache.write('arrivals', @flights, expires_in: 30.seconds)
    end
  end

  def self.get_flights_departures
    if Rails.cache.exist? 'departures'
      @flights = Rails.cache.fetch('departures')
    else
      @flights = FlightsParser::get_departures
      Rails.cache.write('departures', @flights, expires_in: 30.seconds)
    end
  end

  def self.get_harbour_sailings
    SailingsParser::get_sailings
  end
end
