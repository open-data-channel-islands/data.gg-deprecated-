class Api::V10::HealthController < ApplicationController
  def totals
    @title = 'Totals'
    totals_json = File.read("storage/#{ENV['place_code']}/health/chest_and_heart_totals.json")
    @totals = JSON.parse(totals_json)

    respond_to do |format|
      format.json { render json: @totals }
      format.xml { render xml: @totals }
      format.html { render :totals, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def concerns
    @title = 'Concerns'
    concerns_json = File.read("storage/#{ENV['place_code']}/health/chest_and_heart_concerns.json")
    @concerns = JSON.parse(concerns_json)

    respond_to do |format|
      format.json { render json: @concerns }
      format.xml { render xml: @concerns }
      format.html { render :concerns, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end
end
