class Buses::TimetablesController < ApplicationController
  
  def show
    @timetable = Timetable.where('effective_date = ?', params[:date]).first

    @route = Route.new

    respond_to do |format|
      format.html
    end
  end
  
  def download
    
    date = params[:date]
    type = params[:type]
    
    # Based on the type get the data
    
  end
  
end