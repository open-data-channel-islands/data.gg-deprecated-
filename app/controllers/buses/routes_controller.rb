class Buses::RoutesController < ApplicationController
  
  before_action :authenticate_user!, :except => [:show]
  
  # POSTed from the timetables 'show'
  def create
    route = Route.new(route_params)
    
    if route.save
      flash[:success] = "Route '#{route.name}' created"
      redirect_to buses_timetable_path(:start_date => route.timetable.start_date)
    else
      flash[:error] = "Route '#{route.name}' could not be created"
      redirect_to buses_timetable_path(:start_date => route.timetable.start_date)
    end
  end
  
  def edit
    @timetable = Timetable.where(:start_date => params[:timetable_start_date]).first
    @route = Route.find(params[:id])
    
    if @route == nil
      redirect_to buses_path
    end
  end
  
  def update
    @route = Route.find(params[:id])
    if @route != nil
      if @route.update_attributes route_params
        flash[:success] = "Successfully updated route"
      else
        flash[:error] = "An error occurred updating route"
      end
    else
      flash[:error] = "Couldn't find a route with id '#{params[:id]}'"
    end
    
    redirect_to buses_timetable_route_path(@route.timetable.start_date, @route.id)
  end
  
  def destroy
    route = Route.find(params[:id])
    
    if route.destroy
      flash[:success] = "Route #{route.name} destroyed"
      redirect_to buses_timetable_path(params[:timetable_start_date])
    else
      flash[:error] = "Couldn't delete #{route.name}"
      redirect_to buses_timetable_route_path(:timetable_start_date => params[:start], :id => params[:id])
    end
  end
  
  def show
    @route = Route.find_by_id(params[:id])
    
    # Create route_stop which can be edited from this screen
    @route_stop = RouteStop.new
    @route_stop.route = @route
    
    if user_signed_in?
      template = 'show_admin'
    else
      template = 'show'
    end

    respond_to do |format|
      format.xml
      format.html { render template }
    end
  end
  
  def stops
    @route = Route.find_by_id(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  private
  
  def route_params
    params.require(:route).permit(:name, :description, :start_day, :end_day, :timetable_id)
  end
  
  def stop_params
    params.require(:stop).permit(:stop_id, :route_id)
  end
end