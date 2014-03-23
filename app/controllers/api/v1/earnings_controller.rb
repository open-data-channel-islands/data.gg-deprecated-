require 'json'

class Api::V1::EarningsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
    end
  end

  def earnings_age_group
    earnings_json = File.read("storage/earnings_age_group.json")
    @earnings = JSON.parse(earnings_json)
    @earnings.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @earnings }
      format.xml { render xml: @earnings }
      format.html { render html: @earnings }
    end
  end

  def earnings_sector
    earnings_json = File.read("storage/earnings_sector.json")
    @earnings = JSON.parse(earnings_json)
    @earnings.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @earnings }
      format.xml { render xml: @earnings }
      format.html { render html: @earnings }
    end
  end

  def earnings_sex
    earnings_json = File.read("storage/earnings_sex.json")
    @earnings = JSON.parse(earnings_json)
    @earnings.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @earnings }
      format.xml { render xml: @earnings }
      format.html { render html: @earnings }
    end
  end
end
