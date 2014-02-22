class Buses::TimetablesController < ApplicationController
  
  def show
    @timetable = Timetable.where('effective_date = ?', params[:date]).first
    @route = Route.new

    respond_to do |format|
      format.html
    end
  end
  
  def new
    @timetable = Timetable.new
  end
  
  def create
    @timetable = Timetable.new(timetable_params)
    @timetable.save
    
    flash[:success] = "Timetable #{@timetable.name} successfully saved."
    
    redirect_to @timetable
  end
  
  def download
    
    date = params[:date]
    type = params[:type]
    
    # Based on the type get the data
    
  end
  
  private
  
  def timetable_params
    params.require(:timetable).permit(:name, :effective_date)
  end
end