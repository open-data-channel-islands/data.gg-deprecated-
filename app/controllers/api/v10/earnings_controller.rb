require 'json'

class Api::V10::EarningsController < ApplicationController
  before_action :set_earnings_by_sex, only: [:earnings_sex, :index]
  before_action :set_earnings_by_age_group, only: [:earnings_age_group, :index]

  def index
    respond_to do |format|
      format.html { render :index }
    end
  end

  def earnings_age_group
    respond_to do |format|
      format.json { render json: @earnings_age_group }
      format.xml { render xml: @earnings_age_group }
      format.html { render :earnings_age_group, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def earnings_sector
    earnings_json = File.read("storage/earnings_sector.json")
    @earnings = JSON.parse(earnings_json)
    @earnings.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @earnings }
      format.xml { render xml: @earnings }
      format.html { render :earnings_sector, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def earnings_sex
    respond_to do |format|
      format.json { render json: @earnings_sex }
      format.xml { render xml: @earnings_sex }
      format.html { render :earnings_sex, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  private

  def set_earnings_by_sex
    earnings_json = File.read("storage/earnings_sex.json")
    @earnings_sex = JSON.parse(earnings_json)
    @earnings_sex.sort_by! { |c| c['Year'] }
  end

  def set_earnings_by_age_group
    earnings_json = File.read("storage/earnings_age_group.json")
    @earnings_age_group = JSON.parse(earnings_json)
    @earnings_age_group.sort_by! { |c| c['Year'] }
  end
end
