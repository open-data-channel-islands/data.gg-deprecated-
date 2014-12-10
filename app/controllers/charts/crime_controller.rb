class Charts::CrimeController < ApplicationController
  
  def index
    respond_to do |format|
      format.html
    end
  end
  
  def total_crimes
    
    
    
  end
  
  def set_crime_data
    crime_json = File.read("storage/crime.json")
    @crimes = JSON.parse(crime_json)
    @years = @crimes.uniq { |p| p['Year'] }.collect { |p| p['Year'] }
    # Create a hash so you have @bus_usage[year] containing an array of key-value pairs for month->value
    @crimes = Hash[*@crimes.map { |k| [k['Year'], k] }.flatten]
  end
  
end
