class Api::V1::BusesController < ApplicationController
  
  def index
    @timetables = Timetable.order(:start).all
    @latest = @timetables[0]
    @timetable = Timetable.new
    
    respond_to do |format|
      format.html
    end
  end
  
  def current_version
    Timetable.where(:start => params[:start]).select("current_version")
    respond_to do |format|
      format.xml
      format.json
      format.html
    end
  end
  
  def next_version
    
  end
  
  def list
    @timetables = Timetable.order(:start).select("name, start")
    
    respond_to do |format|
      format.xml
      format.json
    end
  end
end