require 'json'

module Api
  class Api::V10::HousingController < ApplicationController
    
    def index
      respond_to do |format|
        format.html { render :index }
      end
    end
    
    def prices
      houses_json = File.read("storage/house_prices.json")
      @house_prices = JSON.parse(houses_json)

      respond_to do |format|
        format.json { render json: @house_prices }
        format.xml { render xml: @house_prices }
        format.html { render html: @house_prices }
      end
    end
    
  end
end