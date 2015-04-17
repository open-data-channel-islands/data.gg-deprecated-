class HomeController < ApplicationController
  layout "application", :only => [ :about, :help ]

  def index
    colors = [["rgba(187, 255, 147, 0.5)", "rgba(87, 149, 50, 0.5)"],
              ["rgba(147, 255, 220, 0.5)", "rgba(38, 113, 88, 0.5)"],
              ["rgba(255, 183, 147, 0.5)", "rgba(170, 95, 57, 0.5)"],
              ["rgba(255, 147, 172, 0.5)", "rgba(156, 52, 76, 0.5)"],
              ["rgba(147, 187, 255, 0.5)", "rgba(38, 87, 149, 0.5)"]]

    bus_usage_json = File.read("storage/bus_usage.json")
    @bus_usage = JSON.parse(bus_usage_json)
    @years = @bus_usage.uniq { |p| p['Year'] }.collect { |p| p['Year'] }
    @months = ['January','February','March','April','May','June','July','August','September','October','November','December']
    # Create a hash so you have @bus_usage[year] containing an array of key-value pairs for month->value
    @bus_usage = Hash[*@bus_usage.map { |k| [k['Year'], k] }.flatten]

    @bus_data = []
    @labels = []

    @years.each do |year|
      values = []
      curr_usage = @bus_usage[year]

      @months.each do |month|
        val = curr_usage[month]
        # Only show it if it exists
        if val != nil
          values << val
        else
          values << 0
        end
      end

      color = colors[colors.length - 1]
      colors.delete_at(colors.length - 1)
      @labels << [year, color[0], color[1]]

      hash = { label: year, :fillColor => color[0], :strokeColor => color[1], :data => values }
      @bus_data << hash
    end

    respond_to do |format|
      format.json
      format.xml
      format.html
    end

  end

  def contact

  end

  def about

  end

  def help

  end
end
