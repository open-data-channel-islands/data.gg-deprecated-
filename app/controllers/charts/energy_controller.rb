class Charts::EnergyController < ApplicationController
  def electricity_consumption
    @title = 'Electricity Consumption'
    electricity_consumption_json = File.read("storage/#{ENV['place_code']}/energy/electricity_consumption.json")
    electricity_consumption = JSON.parse(electricity_consumption_json)

    @labels = []
    @domestic = []
    @commerical = []

    electricity_consumption.sort_by{ |p| p["Year"].to_i }.each do |val|
      @labels << val['Year'].to_i
      @domestic << val['Domestic']
      @commerical << val['Commercial']
    end

    respond_to do |format|
      format.html
    end
  end
end
