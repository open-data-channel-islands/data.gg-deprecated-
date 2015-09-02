require 'json'

class Api::V10::BusesController < ApplicationController

  def usage
    @title = 'Usage'
    bus_json = File.read("storage/#{ENV['place_code']}/buses/bus_usage.json")
    @buses = JSON.parse(bus_json)
    @buses.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @buses }
      format.xml { render xml: @buses }
      format.html { render :usage, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

end



