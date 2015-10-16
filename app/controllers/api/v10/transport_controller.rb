class Api::V10::TransportController < ApplicationController
  def registered_vehicles
    @title = 'Registered Vehicles'
    registered_vehicles_json = File.read("storage/#{ENV['place_code']}/transport/registered_vehicles.json")
    @registered_vehicles = JSON.parse(registered_vehicles_json)

    respond_to do |format|
      format.json { render json: @registered_vehicles }
      format.xml { render xml: @registered_vehicles }
      format.html { render :registered_vehicles, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end
end
