require 'json'

class Api::V10::TrafficController < ApplicationController

  def index
    respond_to do |format|
      format.html { render :index }
    end
  end

  def traffic
    traffic_json = File.read("storage/traffic.json")
    @traffic = JSON.parse(traffic_json)
    @traffic.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @traffic }
      format.xml { render xml: @traffic }
      format.html { render :traffic, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def collisions
    traffic_json = File.read("storage/traffic_collisions.json")
    @traffic = JSON.parse(traffic_json)
    @traffic.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @traffic }
      format.xml { render xml: @traffic }
      format.html { render :collisions, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def injuries
    traffic_json = File.read("storage/traffic_injuries.json")
    @traffic = JSON.parse(traffic_json)
    @traffic.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @traffic }
      format.xml { render xml: @traffic }
      format.html { render :injuries, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def classifications
    traffic_json = File.read("storage/traffic_classifications.json")
    @traffic = JSON.parse(traffic_json)
    @traffic.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @traffic }
      format.xml { render xml: @traffic }
      format.html { render :classifications, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

end
