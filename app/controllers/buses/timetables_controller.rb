class Buses::TimetablesController < ApplicationController
  
  def show
    @timetable = Timetable.where('effective_date = ?', params[:date]).first

    respond_to do |format|
      format.html
    end
  end
  
end