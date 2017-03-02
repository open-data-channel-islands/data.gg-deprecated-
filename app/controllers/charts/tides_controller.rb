class Charts::TidesController < ApplicationController
  def tides
    @title = 'Tides'
    tides_json = File.read("storage/#{ENV['place_code']}/tides/tides.json")
    tides = JSON.parse(tides_json)

    @labels = []

    @time_periods = []
    @time_periods[0] = []
    @time_periods[1] = []
    @time_periods[2] = []
    @time_periods[3] = []

    @heights = []
    @heights[0] = []
    @heights[1] = []
    @heights[2] = []
    @heights[3] = []

    tides.group_by{|p| p['date']}.each do |date, onDate|
      @labels << date

      onDate.each_with_index do |t, i|
        @time_periods[i] << t['time']
        @heights[i] << t['height'].to_f
      end
    end

    respond_to do |format|
      format.html
    end
  end
end
