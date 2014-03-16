class BusesController < ApplicationController
  
  def index
    @timetables = Timetable.order(:start).all
    @latest = @timetables[0]
    
    respond_to do |format|
      format.html
    end
  end
  
  
  
end
