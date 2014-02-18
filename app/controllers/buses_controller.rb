class BusesController < ApplicationController
  
  def index
    @timetables = Timetable.all
    
    respond_to do |format|
      format.html
    end
  end
  
  
  
end
