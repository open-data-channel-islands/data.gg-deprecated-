class Api::V1::Buses::RouteStopsController < ApplicationController
  
  def create
    route_stop = RouteStop.new(route_stop_params)

    # This gets the very first route_stop instance
    rs = RouteStop.where(route_id: route_stop.route.id).order(:idx).first()
    idx = 0
    print idx
    if rs
      idx = rs.idx
    end
    
    print idx
    
    route_stop.idx = idx + 1

    if route_stop.save
      flash[:success] = "Successfully saved route stop"
      redirect_to api_v1_buses_timetable_route_path(route_stop.route.timetable.start, route_stop.route.id)
    else
      flash[:error] = "Couldn't create route stop"
      redirect_to api_v1_buses_timetable_route_path(route_stop.route.timetable.start, route_stop.route.id)
    end
  end
  
  def create_stop_links
    stop_links_array = params[:stop_links]
    
    sl_arr = Array.new
    
    stop_links_array.each do |stop_link|
      # replace a colon if one exists so it can be converted from string to int
      stop_link[1]["time"] = stop_link[1]["time"].sub! ':', ''
      sl = StopLink.new(stop_link[1])
      
      # If it's the first link, then itself is the origin
      if sl_arr.count > 0
        sl.origin_stop_link = sl_arr[0]
      else
        sl.origin_stop_link = sl
      end
      
      sl_arr << sl
      
      sl.save
      if sl.errors.any?
        sl.errors_full_messages.each do |err|
          p err
        end
      end
    end
    
    redirect_to api_v1_buses_timetable_route_path(params[:timetable_start_date], params[:route_id])
  end
  
  def destroy
    route_stop = RouteStop.find(params[:route_stop_id])
    
    if route_stop
      # Need to destroy the links, too
      StopLink.destroy_all(route_stop_id: route_stop.id)
      route_stop.destroy
      flash[:success] = "Successfully deleted an occurrence of '#{route_stop.stop.name}' on route '#{route_stop.route.name}'"
    else
      flash[:error] = "Couldn't find the stop!"
    end
  end
  
  private
  
  def route_stop_params
    params.require(:route_stop).permit(:idx, :display, :stop_id, :route_id)
  end
  
  def route_params
    params.permit(:route_id)
  end
  
end