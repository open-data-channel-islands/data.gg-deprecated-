class Charts::BusesController < ApplicationController

  before_action :set_bus_data

  def usage
    @title = 'Usage'
    @labels = []
    @users = []

    @years.each do |year|
      @months.each do |month|
        val = @bus_usage[year][month]
        @labels << month.to_s + ' ' + year.to_s
        @users << val
      end
    end

    respond_to do |format|
      format.html
    end
  end


  def split
    @bus_data = []

    @years.each do |year|
      values = []
      curr_usage = @bus_usage[year]

      @months.each do |month|
        val = curr_usage[month]
        # Only show it if it exists
        if val != nil
          values << val
        end
      end

      hash = { :fillColor => "rgba(50,50,0,1)", :strokeColor => "rgba(100,100,100,1)",
        :pointColor => "rgba(100,100,100,1)", :pointStrokeColor => "#FFFFFF",
        :data => values }
      @bus_data << hash
    end

    respond_to do |format|
      format.json { render json: @bus_data, layout: false }
      format.xml { render xml: @bus_data, layout: false }
      format.html { render html: @bus_data, layout: false }
    end
  end

  def set_bus_data
    bus_usage_json = File.read("storage/bus_usage.json")
    @bus_usage = JSON.parse(bus_usage_json)
    @years = @bus_usage.uniq { |p| p['Year'] }.sort_by { |p| p['Year'] }.collect { |p| p['Year'] }
    @months = ['January','February','March','April','May','June','July','August','September','October','November','December']
    # Create a hash so you have @bus_usage[year] containing an array of key-value pairs for month->value
    @bus_usage = Hash[*@bus_usage.map { |k| [k['Year'], k] }.flatten]
  end
end