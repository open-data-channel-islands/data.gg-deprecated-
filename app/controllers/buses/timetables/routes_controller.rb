class Buses::Timetables::RoutesController < ApplicationController
  
  # Not used yet
  def index
    @routes = Route.all
    
    respond_to do |format|
      format.html
    end
  end
  
  # POSTed from the timetables 'show'
  def create
    @route = Route.new(route_params)
    # TODO: See if this is right?
    @route.timetable = Timetable.where("effective_date = ?", params[:date]).first
    @route.save
    
    flash[:success] = "Route created"
    
    redirect_to buses_timetable_path(:date => params[:date])
  end
  
  def destroy
    @route = Route.find(params[:id])
    @route.destroy
    flash[:success] = "Route destroyed"
    redirect_to buses_timetable_path(:date => params[:date])
  end
  
  def show
    
  end
  
  private
  
  def route_params
    params.require(:route).permit(:name, :description, :start_day, :end_day)
  end
end