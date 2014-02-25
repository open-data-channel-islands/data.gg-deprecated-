class BusesController < ApplicationController
  
  def index
    @timetables = Timetable.order(:effective_date).all
    @latest = @timetables[0]
    
    respond_to do |format|
      format.html
    end
  end
  
  
  
end
