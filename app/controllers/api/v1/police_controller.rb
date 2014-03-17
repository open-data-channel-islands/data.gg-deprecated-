require 'json'

class Api::V1::PoliceController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
    end
  end

  def crimes


    crime_json = File.read("storage/crime.json")
    @crimes = JSON.parse(crime_json)
    @crimes.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @crimes }
      format.xml { render xml: @crimes }
      format.html { render html: @crimes }
    end
  end
end
