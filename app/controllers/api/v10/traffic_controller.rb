require 'json'

class Api::V10::TrafficController < ApplicationController

  def traffic
    @title = 'Traffic'
    traffic_json = File.read("storage/#{ENV['place_code']}/traffic/traffic.json")
    @traffic = JSON.parse(traffic_json)
    @traffic.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @traffic }
      format.xml { render xml: @traffic }
      format.html { render :traffic, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def collisions
    @title = 'Collisions'
    traffic_json = File.read("storage/#{ENV['place_code']}/traffic/traffic_collisions.json")
    @traffic = JSON.parse(traffic_json)
    @traffic.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @traffic }
      format.xml { render xml: @traffic }
      format.html { render :collisions, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def injuries
    @title = 'Injuries'
    traffic_json = File.read("storage/#{ENV['place_code']}/traffic/traffic_injuries.json")
    @traffic = JSON.parse(traffic_json)
    @traffic.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @traffic }
      format.xml { render xml: @traffic }
      format.html { render :injuries, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def classifications
    @title = 'Classifications'
    traffic_json = File.read("storage/#{ENV['place_code']}/traffic/traffic_classifications.json")
    @traffic = JSON.parse(traffic_json)
    @traffic.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @traffic }
      format.xml { render xml: @traffic }
      format.html { render :classifications, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

end
