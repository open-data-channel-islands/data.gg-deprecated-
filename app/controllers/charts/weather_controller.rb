class Charts::WeatherController < ApplicationController
  def totals
    @title = 'Totals'
    monthly_json = File.read("storage/#{ENV['place_code']}/weather/metoffice_monthly_report.json")
    @monthly = JSON.parse(monthly_json)
    month_sort_order = [ 'JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC' ]
    @monthly.sort_by! { |m| [ m['year'].to_i, month_sort_order.index(m['month']) ] }

    @labels = []
    @rain = []
    @sun = []
    @temp = []

    @monthly.each do |m|
      @labels << "#{m['month']} #{m['year']}"
      @temp << m['temperature']
      @sun << m['sunshine']
      @rain << m['rainfall']
    end

    respond_to do |format|
      format.html
    end
  end

  def frost_days
    @title = 'Frost Days'
    frost_days_json = File.read("storage/#{ENV['place_code']}/weather/frost_days.json")
    frost_days = JSON.parse(frost_days_json)

    @labels = []
    @frost_days = []

    frost_days.sort_by{ |p| p["Period"][0...4].to_i }.each do |val|
      @labels << val['Period']
      @frost_days << val['Total no. of frost days']
    end

    respond_to do |format|
      format.html
    end
  end
end
