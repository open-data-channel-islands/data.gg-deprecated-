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

  def air_by_month
    @title = 'Air by Month'
    air_by_month_json = File.read("storage/#{ENV['place_code']}/tourism/air_by_month.json")
    @air_by_month = JSON.parse(air_by_month_json)

    respond_to do |format|
      format.json { render json: @air_by_month }
      format.xml { render xml: @air_by_month }
      format.html { render :air_by_month, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def sea_by_month
    @title = 'Sea by Month'
    sea_by_month_json = File.read("storage/#{ENV['place_code']}/tourism/sea_by_month.json")
    @sea_by_month = JSON.parse(sea_by_month_json)

    respond_to do |format|
      format.json { render json: @sea_by_month }
      format.xml { render xml: @sea_by_month }
      format.html { render :sea_by_month, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end
end
