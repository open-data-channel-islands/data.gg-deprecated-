class Charts::WaterController < ApplicationController
  def domestic_consumption
    @title = 'Domestic Consumption'
    domestic_consumption_json = File.read("storage/water/domestic_consumption.json")
    domestic_consumption = JSON.parse(domestic_consumption_json)

    @domestic_consumption = []
    @labels = []

    domestic_consumption.sort_by{|p| p["Year"].to_i}.each do |val|
      @labels << val['Year'].to_i
      @domestic_consumption << val['Consumption'].to_i
    end

    respond_to do |format|
      format.html
    end
  end
end
