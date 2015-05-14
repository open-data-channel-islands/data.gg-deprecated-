require 'nokogiri'
require 'open-uri'
require 'time'
class Api::V10::FlightsController < ApplicationController
  require_dependency 'flights_parser'

  def departures
    @title = 'Departures'
    @flights = FlightsParser::get_departures
    respond_to do |format|
      format.json { render json: @flights }
      format.xml { render xml: @flights }
      format.html { render :departures, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def arrivals
    @title = 'Arrivals'
    @flights = FlightsParser::get_arrivals
    respond_to do |format|
      format.json { render json: @flights }
      format.xml { render xml: @flights }
      format.html { render :arrivals, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end

  end

end
