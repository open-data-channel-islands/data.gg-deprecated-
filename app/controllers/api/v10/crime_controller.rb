require 'json'

class Api::V10::CrimeController < ApplicationController

  def crimes
    @title = 'Crimes'
    crime_json = File.read("storage/#{ENV['place_code']}/crime/crime.json")
    @crimes = JSON.parse(crime_json)

    respond_to do |format|
      format.json { render json: @crimes }
      format.xml { render xml: @crimes }
      format.html { render :crimes, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def prison_population
    @title = 'Prison Population'
    prison_pop_json = File.read("storage/#{ENV['place_code']}/crime/prison_population.json")
    @prison_pop = JSON.parse(prison_pop_json)

    respond_to do |format|
      format.json { render json: @prison_pop }
      format.xml { render xml: @prison_pop }
      format.html { render :prison_population, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def worried
    @title = 'Worried'
    worried_json = File.read("storage/#{ENV['place_code']}/crime/worried.json")
    @worried = JSON.parse(worried_json)

    respond_to do |format|
      format.json { render json: @worried }
      format.xml { render xml: @worried }
      format.html { render :worried, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

end



