class Api::V1::Buses::RouteStopsController < ApplicationController
  
  before_action :authenticate_user!
  
  def create
    route_stop = RouteStop.new(route_stop_params)

    # This gets the very first route_stop instance
    rs = RouteStop.where(route_id: route_stop.route.id).order(:idx).first()
    
    idx = 0
    print idx
    if rs
      idx = rs.idx
    end
    
    route_stop.idx = idx + 1

    if route_stop.save
      flash[:success] = "Successfully added stop '#{route_stop.stop.name}' to route '#{route_stop.route.name}'"
      redirect_to api_v1_buses_timetable_route_path(route_stop.route.timetable.start, route_stop.route.id) + '#stops'
    else
      flash[:error] = "Couldn't add stop on this route: #{route_stop.errors.full_messages}"
      redirect_to api_v1_buses_timetable_route_path(route_stop.route.timetable.start, params[:route_id])
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
  
  # We have to do quite a bit of work here to make sure everything gets re-aligned
  def destroy
    route_stop = RouteStop.find(params[:id])
    
    if !route_stop
      flash[:error] = "Couldn't find a stop for '#{params[:id]}"
      redirect_to
    end
    
    if route_stop.origin_route_stop = route_stop
      next_idx = route_stop.idx + 1
      # Not finished, this is saying that if it's the origin
      # route_stop that we're deleting then we need to change
      # the origin points to the 'next' one. So idx '1' will
      # become '0' and then need to update RouteStop so
      # origin_stop_link_id is that Route_Stop.
      RouteStop.where("idx = #{next_idx}")
    end
    
    route_stop.destroy
    # Negate the indexes as they might be like 0,1,3,4
    RouteStop.where("idx >= #{route_stop.idx}").update_all("idx = idx - 1")
    # Destroy all related stop links
    StopLink.destroy_all(route_stop_id: route_stop.id)
    
    flash[:success] = "Successfully deleted an occurrence of '#{route_stop.stop.name}' on route '#{route_stop.route.name}'"

    redirect_to api_v1_buses_timetable_route_path(params[:timetable_start_date], params[:route_id]) + '#stops'
  end
  
  private
  
  def route_stop_params
    params.require(:route_stop).permit(:idx, :display, :stop_id, :route_id)
  end
  
  def route_params
    params.permit(:route_id)
  end
  
end