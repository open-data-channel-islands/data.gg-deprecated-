class Charts::TrafficController < ApplicationController

  def classifications
    @title = 'Classifications'
    classifications_json = File.read("storage/traffic_classifications.json")
    classifications = JSON.parse(classifications_json)

    @fatals = []
    @seriouses = []
    @slights = []
    @labels = []

    classifications.sort_by{|p| p["Year"].to_i}.each do |val|
      @labels << val['Year'].to_i

      @fatals << val['Fatal']
      @seriouses << val['Serious']
      @slights << val['Slight']
    end

    respond_to do |format|
      format.html
    end
  end

  def collisions
    @title = 'Collisions'
    collisions_json = File.read("storage/traffic_collisions.json")
    collisions = JSON.parse(collisions_json)

    @collisions = []
    @labels = []

    collisions.sort_by{|p| p["Year"].to_i}.each do |val|
      @labels << val['Year'].to_i
      @collisions << val['Collisions'].to_i
    end

    respond_to do |format|
      format.html
    end
  end



end
