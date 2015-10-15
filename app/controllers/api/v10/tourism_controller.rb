class Api::V10::TourismController < ApplicationController
  def cruises
    @title = 'Cruises'
    cruises_json = File.read("storage/#{ENV['place_code']}/tourism/cruises.json")
    @cruises = JSON.parse(cruises_json)

    respond_to do |format|
      format.json { render json: @cruises }
      format.xml { render xml: @cruises }
      format.html { render :cruises, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end
end
