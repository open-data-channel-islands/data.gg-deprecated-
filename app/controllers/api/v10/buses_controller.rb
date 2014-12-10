require 'json'

class Api::V10::BusesController < ApplicationController

  def index
    respond_to do |format|
      format.html { render :index }
    end
  end

  def usage
    bus_json = File.read("storage/bus_usage.json")
    @buses = JSON.parse(bus_json)
    @buses.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @buses }
      format.xml { render xml: @buses }
      format.html { render html: @buses, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

end



