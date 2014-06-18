class Api::V1::BusesController < ApplicationController
  
  def index
    @timetables = Timetable.order(:start_date).all
    @latest = @timetables[0]
    @timetable = Timetable.new
    
    respond_to do |format|
      format.html
    end
  end
  
  def current_version
    Timetable.where(:start_date => params[:start]).select("current_version")
    respond_to do |format|
      format.xml
      format.json
      format.html
    end
  end
  
  def next_version
    
  end
  
  def list
    @timetables = Timetable.order(:start_date).select("name, start")
    
    respond_to do |format|
      format.xml
      format.json
    end
  end
end