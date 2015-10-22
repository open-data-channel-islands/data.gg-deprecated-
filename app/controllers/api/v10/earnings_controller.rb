require 'json'

class Api::V10::EarningsController < ApplicationController
  before_action :set_earnings_by_sex, only: [:earnings_sex, :index]
  before_action :set_earnings_by_age_group, only: [:earnings_age_group, :index]

  def earnings_age_group
    @title = 'Earnings by Age Group'
    respond_to do |format|
      format.json { render json: @earnings_age_group }
      format.xml { render xml: @earnings_age_group }
      format.html { render :earnings_age_group, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def earnings_sector
    @title = 'Earnings by Sector'
    earnings_json = File.read("storage/#{ENV['place_code']}/earnings/earnings_sector.json")
    @earnings = JSON.parse(earnings_json)

    respond_to do |format|
      format.json { render json: @earnings }
      format.xml { render xml: @earnings }
      format.html { render :earnings_sector, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def earnings_sex
    @title = 'Earnings by Sex'
    respond_to do |format|
      format.json { render json: @earnings_sex }
      format.xml { render xml: @earnings_sex }
      format.html { render :earnings_sex, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  private

  def set_earnings_by_sex
    earnings_json = File.read("storage/#{ENV['place_code']}/earnings/earnings_sex.json")
    @earnings_sex = JSON.parse(earnings_json)
  end

  def set_earnings_by_age_group
    earnings_json = File.read("storage/#{ENV['place_code']}/earnings/earnings_age_group.json")
    @earnings_age_group = JSON.parse(earnings_json)
  end
end
