class Buses::RoutesController < ApplicationController
  
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
    
    @route.timetable = Timetable.find_by_id(route_params[:timetable_id])
    
    if !@route.timetable
      # error
    end
    @route.save
    
    flash[:success] = "Route created"
    
    redirect_to buses_timetable_path(:date => @route.timetable.effective_date)
  end
  
  def destroy
    @route = Route.find(params[:id])
    @route.destroy
    flash[:success] = "Route destroyed"
    redirect_to buses_timetable_path(:date => params[:date])
  end
  
  def show
    @route = Route.find_by_id(params[:id])
    @timetable = @route.timetable
    @route_stop = RouteStop.new
    
    
    # order = the ORIGIN time (start of each one) and THEN by route stop INDEX
    #       = so spits it out just like the actual PDF timetable. Some 
    #       = post-processing required to put it into an array
    @stop_links = StopLink.joins(:route_stop).joins(:origin_stop_link).where("route_stop.route_id = ?", @route.id).order("origin_stop_link.time ASC").all
    

    respond_to do |format|
      format.html
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