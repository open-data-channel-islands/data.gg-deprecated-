require 'json'

module Api
  class Api::V10::HousingController < ApplicationController

    def index
      respond_to do |format|
        format.html { render :index }
      end
    end

    def local_prices
      houses_json = File.read("storage/houses/local_prices.json")
      @house_prices = JSON.parse(houses_json)

      respond_to do |format|
        format.json { render json: @house_prices }
        format.xml { render xml: @house_prices }
        format.html { render :local_prices, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
      end
    end

    def open_prices
      houses_json = File.read("storage/houses/open_prices.json")
      @house_prices = JSON.parse(houses_json)

      respond_to do |format|
        format.json { render json: @house_prices }
        format.xml { render xml: @house_prices }
        format.html { render :open_prices, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
      end
    end

  end
end