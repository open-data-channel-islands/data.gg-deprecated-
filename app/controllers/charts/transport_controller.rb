class Charts::TransportController < ApplicationController
  def registered_vehicles
    @title = 'Registered Vehicles'
    registered_vehicles_json = File.read("storage/#{ENV['place_code']}/transport/registered_vehicles.json")
    registered_vehicles = JSON.parse(registered_vehicles_json)

    @labels = []
    @vehicle_private = []
    @vehicle_commerical = []
    @motorbike = []

    registered_vehicles.sort_by{ |p| p["Year"].to_i }.each do |val|
      @labels << val['Year'].to_i
      @vehicle_private << val['Motor Vehicles Private']
      @vehicle_commerical << val['Motor Vehicles Commercial']
      @motorbike << val['Motor Cycles']
    end

    respond_to do |format|
      format.html
    end
  end
end
