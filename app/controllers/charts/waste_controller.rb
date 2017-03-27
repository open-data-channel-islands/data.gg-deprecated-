class Charts::WasteController < ApplicationController

  def commercial_and_industrial_vs_household
    @title = 'Commercial and Industrial vs Household'

    household_json = File.read("storage/#{ENV['place_code']}/waste/household_waste.json")
    household = JSON.parse(household_json)

    commercial_and_industrial_json = File.read("storage/#{ENV['place_code']}/waste/commercial_and_industrial_waste.json")
    commercial_and_industrial = JSON.parse(commercial_and_industrial_json)

    @results = []

    @labels = household.uniq { |p| p['Year'] }.sort_by{ |p| p["Year"].to_i }.collect { |p| p['Year'].to_i }

    landfill = []
    recycled = []
    composted = []

    household.sort_by{ |p| p["Year"].to_i }.each do |h|
      landfill << h['Landfill']
      recycled << h['Recycled']
      composted << h['Composted']
    end

    @results << { name: 'Household Landfill', data: landfill }
    @results << { name: 'Household Recycled', data: recycled }
    @results << { name: 'Household Composted', data: composted }


    landfill = []
    recycled = []
    composted = []

    commercial_and_industrial.sort_by{ |p| p["Year"].to_i }.each do |h|
      landfill << h['Landfill']
      recycled << h['Recycled']
      composted << h['Composted']
    end


      @results << { name: 'Commercial and Industrial Landfill', data: landfill }
      @results << { name: 'Commercial and Industrial Recycled', data: recycled }
      @results << { name: 'Commercial and Industrial Composted', data: composted }

    respond_to do |format|
      format.html
    end
  end

end
