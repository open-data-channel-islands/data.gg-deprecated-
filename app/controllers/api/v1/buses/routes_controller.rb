class Api::V1::Buses::RoutesController < ApplicationController
  
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
    
    if !@route.timetable
      # error
    end
    @route.save
    
    flash[:success] = "Route created"
    
    redirect_to buses_timetable_path(:start_date => @route.timetable.start)
  end
  
  def destroy
    @route = Route.find_by_id(params[:id])
    
    respond_to do |f|
      if @route.destroy
        flash[:success] = "Route destroyed"
        redirect_to buses_timetable_path(:start_date => params[:start])
      else
        redirect_to buses_timetable_route(:start_date => params[:start], :id => params[:id])
      end
    end
  end
  
  def show
    @route = Route.find_by_id(params[:id])
    @timetable = @route.timetable
    
    # Create route_stop which can be edited from this screen
    @route_stop = RouteStop.new
    @route_stop.route = @route
    
    
    @new_stop_link_set = []
    @route.route_stops.each do |route_stop|
      sl = StopLink.new
      sl.route_stop = route_stop
      sl.display = true
      sl.skip = route_stop = false
      sl.arrive = false
      sl.depart = true
      if @new_stop_link_set.count > 0
        sl.origin_stop_link = @new_stop_link_set[0]
      else
        sl.origin_stop_link = sl
      end
      
      @new_stop_link_set << sl
      
    end
    
    @ordered_route_stops = @route.route_stops.order(:idx).all

    tmp_stop_links = StopLink.joins("INNER JOIN route_stops rs ON rs.id = stop_links.route_stop_id")
                          .joins("INNER JOIN stop_links origin ON origin.id = stop_links.origin_stop_link_id")
                          .where("rs.route_id = ?", @route.id)
                          .order("origin.time ASC, rs.idx DESC")
                          .all
                          
    overall_set = [] # Contains ALL the stop links
    curr_set = [] # Contains CURRENT set
    curr_origin_time = nil
    tmp_stop_links.each do |stop_link|
      if curr_origin_time != stop_link.origin.time
        overall_set << curr_set
        curr_set = []
      end
      
      curr_set << stop_link
      
    end
    
    overall_set.each do |stops|
      stops.each do |stop|
        
      end
    end
    
    @stop_links = tmp_stop_links
                          
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