require 'nokogiri'
require 'open-uri'

class Api::V1::SailingsController < ApplicationController

  def index
    respond_to do |format|
      format.html { render :index }
    end
  end

  def harbour

    @sailings = SailingsParser::get_sailings

    respond_to do |format|
      format.json { render json: @sailings }
      format.xml { render xml: @sailings }
      format.html { render html: @sailings }
    end
  end

  def herm_trident
    herm_trident_json = File.read("storage/#{ENV['place_code']}/herm_trident.json")
    @herm_tridents = JSON.parse(herm_trident_json)
    @herm_tridents.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @herm_tridents }
      format.xml { render xml: @herm_tridents }
      format.html { render html: @herm_tridents }
    end
  end
end
