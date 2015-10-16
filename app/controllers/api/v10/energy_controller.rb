class Api::V10::EnergyController < ApplicationController
  def electricity_consumption
    @title = 'Electricity Consumption'
    electricity_consumption_json = File.read("storage/#{ENV['place_code']}/energy/electricity_consumption.json")
    @electricity_consumption = JSON.parse(electricity_consumption_json)

    respond_to do |format|
      format.json { render json: @electricity_consumption }
      format.xml { render xml: @electricity_consumption }
      format.html { render :electricity_consumption, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end
end
