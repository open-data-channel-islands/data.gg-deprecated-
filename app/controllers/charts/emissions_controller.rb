class Charts::EmissionsController < ApplicationController
  def types
    @title = 'Types'
    types_json = File.read("storage/#{ENV['place_code']}/emissions/type.json")
    types = JSON.parse(types_json)

    @carbon_dioxide = []
    @methane = []
    @nitrous_oxide = []
    @f_gases = []
    @labels = []

    types.sort_by{|p| p["Year"].to_i}.each do |val|
      @labels << val['Year'].to_i

      @carbon_dioxide << val['Carbon Dioxide']
      @methane << val['Methane']
      @nitrous_oxide << val['Nitrous Oxide']
      @f_gases << val['F-Gases']

    end

    respond_to do |format|
      format.html
    end
  end
end
