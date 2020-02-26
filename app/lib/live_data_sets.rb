class  LiveDataSets

    def  self.get_flights_arrivals
        flights  =  []
        if  Rails.cache.exist?  'arrivals'
            flights  =  Rails.cache.fetch('arrivals')
        else
            flights  =  FlightsParser::get_arrivals
            Rails.cache.write('arrivals',  flights,  expires_in:  30.seconds)
        end
        flights
    end

    def  self.get_flights_departures
        flights  =  []
        if  Rails.cache.exist?  'departures'
            flights  =  Rails.cache.fetch('departures')
        else
            flights  =  FlightsParser::get_departures
            Rails.cache.write('departures',  flights,  expires_in:  30.seconds)
        end
        flights
    end

    def  self.get_harbour_sailings
        sailings  =  SailingsParser::get_sailings
        sailings
    end
end