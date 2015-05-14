class BespokeController < ApplicationController
  layout 'bespoke'

  def gp_flights_arrivals
    @flights = FlightsParser::get_arrivals
  end

  def gp_flights_departures
    @flights = FlightsParser::get_departures
  end
end
