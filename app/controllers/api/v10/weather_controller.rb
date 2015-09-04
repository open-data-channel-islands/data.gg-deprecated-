class Api::V10::WeatherController < ApplicationController
  def annual
    @title = 'Annual'
    annual_json = File.read("storage/#{ENV['place_code']}/weather/metoffice_annual_report.json")
    @annual = JSON.parse(annual_json)
    @annual.sort_by! {|a| a['year']}

    respond_to do |format|
      format.json { render json: @annual }
      format.xml { render xml: @annual }
      format.html { render :annual, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def monthly
    @title = 'Monthly'
    monthly_json = File.read("storage/#{ENV['place_code']}/weather/metoffice_monthly_report.json")
    @monthly = JSON.parse(monthly_json)
    month_sort_order = [ 'JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC' ]
    @monthly.sort_by! { |m| [ m['year'].to_i, month_sort_order.index(m['month']) ] }

    respond_to do |format|
      format.json { render json: @monthly }
      format.xml { render xml: @monthly }
      format.html { render :monthly, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end
end
