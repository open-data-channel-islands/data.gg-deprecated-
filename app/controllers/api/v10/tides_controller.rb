class Api::V10::TidesController < ApplicationController
  def tides
    @title = 'Tides'
    tides_json = File.read("storage/#{ENV['place_code']}/tides/tides.json")
    @tides = JSON.parse(tides_json)

    respond_to do |format|
      format.json { render json: @tides }
      format.xml { render xml: @tides }
      format.html { render :tides, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

end
