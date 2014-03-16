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
    
    redirect_to buses_timetable_path(:start_date => @route.timetable.start)
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
    
    @route.route_stops.each do |rs|
      
    end

    @stop_links = StopLink.joins("INNER JOIN route_stops rs ON rs.id = stop_links.route_stop_id")
                          .joins("INNER JOIN stop_links origin ON origin.id = stop_links.origin_stop_link_id")
                          .where("rs.route_id = ?", @route.id)
                          .order("origin.time ASC, rs.idx DESC")
                          .all
                          
    # Now we loop through until we find the origin time has changed, then add it to a collection. This will
    # organise each stop_link entry in a two-dimensional array instead
    

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
  
  def create_stop_link_chain
    
  end
  
  private
  
  def route_params
    params.require(:route).permit(:name, :description, :start_day, :end_day, :timetable_id)
  end
  
  def stop_params
    params.require(:stop).permit(:stop_id, :route_id)
  end
end