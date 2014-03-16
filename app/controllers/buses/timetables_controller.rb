class Buses::TimetablesController < ApplicationController
  
  def show
    @timetable = Timetable.first #where('effective_date = ?', params[:timetable_date]).first
    @route_overview = RouteOverview.new
    @route_period = RoutePeriod.new

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
  #  
    flash[:success] = "Timetable #{@timetable.name} successfully saved."
  #  
    redirect_to buses_timetable_path(:date => @timetable.effective_date)
  end
  
  #def download
    
  #  date = params[:date]
  #  type = params[:type]
    
    # Based on the type get the data
    
    #end
  
  private
  
  def timetable_params
    params.require(:timetable).permit(:name, :effective_date)
  end
end