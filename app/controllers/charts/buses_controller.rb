class Charts::BusesController < ApplicationController
  
  before_action :set_bus_data, only: [:index]
  
  def index
    
    # Here we create the data we need to 
    @bus_data = []
    @labels = []
    values = []
    
    @years.each do |year|
      
      curr_usage = @bus_usage[year]
      
      @months.each do |month|
        
        # Add the label
        val = curr_usage[month]
        
        # Because if it's completely null, then we may not actually have it,
        # so don't bother populating it at all.
        if val != nil
          @labels << month.to_s + ' ' + year.to_s
          values << val
        end
      end
    end
    
    hash = { :fillColor => "rgba(50,50,0,1)", :strokeColor => "rgba(100,100,100,1)",
      :pointColor => "rgba(100,100,100,1)", :pointStrokeColor => "#FFFFFF",
      :data => values }
    @bus_data << hash
    
  end
  
  def set_bus_data
    bus_usage_json = File.read("storage/bus_usage.json")
    @bus_usage = JSON.parse(bus_usage_json)
    @years = @bus_usage.uniq { |p| p['Year'] }.collect { |p| p['Year'] }
    @months = ['January','February','March','April','May','June','July','August','September','October','November','December']
    # Create a hash so you have @bus_usage[year] containing an array of key-value pairs for month->value
    @bus_usage = Hash[*@bus_usage.map { |k| [k['Year'], k] }.flatten]
  end
end