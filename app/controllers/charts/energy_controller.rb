class Charts::EnergyController < ApplicationController

  def renewable
    @title = 'Renewable'
    renewable_json = File.read("storage/#{ENV['place_code']}/energy/renewable_energy.json")
    renewable = JSON.parse(renewable_json)

    @labels = []
    @renewable = []

    renewable.sort_by{ |p| p["Year"].to_i }.each do |val|
      @labels << val['Year'].to_i
      @renewable << val['Renewable Energy']
    end

    respond_to do |format|
      format.html
    end
  end

  def electricity_consumption
    @title = 'Electricity Consumption'
    electricity_consumption_json = File.read("storage/#{ENV['place_code']}/energy/electricity_consumption.json")
    electricity_consumption = JSON.parse(electricity_consumption_json)

    @labels = []
    @domestic = []
    @commerical = []

    electricity_consumption.sort_by{ |p| p["Year"].to_i }.each do |val|
      @labels << val['Year'].to_i
      @domestic << val['Domestic']
      @commerical << val['Commercial']
    end

    respond_to do |format|
      format.html
    end
  end

   def electricity_import_vs_generated
    @title = 'Electricity Imported VS Generated'
    electricity_import_vs_generated_json = File.read("storage/#{ENV['place_code']}/energy/electricity_import_vs_generated.json")
    electricity_import_vs_generated = JSON.parse(electricity_import_vs_generated_json)

    @labels = []
    @imported = []
    @generated = []

    electricity_import_vs_generated.sort_by{ |p| p["Year"].to_i }.each do |val|
      @labels << val['Year'].to_i
      @imported << val['Electricity Imported MWh']
      @generated << val['Electricity Generated MWh']
    end

    respond_to do |format|
      format.html
    end
  end
end
