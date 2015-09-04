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
end
