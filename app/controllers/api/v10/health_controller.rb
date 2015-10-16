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

  def med_unit_bed_days_five_yr_avg
    @title = 'Medical Unit Bed Days Five Year Average'
    med_unit_bed_days_five_yr_avg_json = File.read("storage/#{ENV['place_code']}/health/med_unit_bed_days_five_yr_avg.json")
    @med_unit_bed_days_five_yr_avg = JSON.parse(med_unit_bed_days_five_yr_avg_json)

    respond_to do |format|
      format.json { render json: @med_unit_bed_days_five_yr_avg }
      format.xml { render xml: @med_unit_bed_days_five_yr_avg }
      format.html { render :med_unit_bed_days_five_yr_avg, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end
end
