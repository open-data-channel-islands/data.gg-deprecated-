class Buses::TimetablesController < ApplicationController
  
  def show
    year = params[:year]
    month = params[:month]
    day = params[:day]
    "#{year}#{month}#{day}"
    @timetable = Timetable.where('extract(year from effective_date) = ?
      && extract(month from effective_day) = ?
      && extract(day from effectve_day) = ?', year, month, day)
      
    respond_to do |format|
      format.html
    end
  end
  
end