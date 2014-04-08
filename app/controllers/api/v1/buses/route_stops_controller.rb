class Api::V1::Buses::RouteStopsController < ApplicationController
  
  before_action :authenticate_user!
  
  def create
    route_stop = RouteStop.new(route_stop_params)

    # This gets the very first route_stop instance
    rs = RouteStop.where(route_id: route_stop.route.id).order(:idx).last()
    
    idx = 0
    print idx
    if rs
      idx = rs.idx
      route_stop.idx = idx + 1
    else
      route_stop.idx = 0
    end
    
    did_error = false
    
    if route_stop.save
      # If it's not the only route stop
      if idx > 0
        #prior_route_stop = RouteStop.where(route_id: route_stop.route.id, idx: (idx - 1))
        stop_links = StopLink.where(route_stop: rs).all
        p "COUNT COUNT COUNT: " + stop_links.count.to_s

        stop_links.each do |sl|
          p "CREATING"
          new_sl = StopLink.new
          new_sl.origin_stop_link = sl.origin_stop_link
          new_sl.time = sl.time + 1
          new_sl.route_stop = route_stop
          new_sl.route = route_stop.route
          new_sl.depart = true
          new_sl.arrive = false
          new_sl.skip = false
          new_sl.night = false
          
          if !new_sl.save!
            p new_sl.error.full_messages
            did_error = true
            flash[:error] = "Uh-oh. Couldn't create the new stop because we couldn't arrange the stop links."
          end
        end
      end 
      
      if !did_error
        flash[:success] = "Successfully added stop '#{route_stop.stop.name}' to route '#{route_stop.route.name}' at index '#{route_stop.idx}'"
      end
      
    else
      flash[:error] = "Couldn't add stop on this route: #{route_stop.errors.full_messages}"
    end
    
    redirect_to api_v1_buses_timetable_route_path(route_stop.route.timetable.start, route_stop.route.id) + '#stops'
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
    route_stop_pending_destroy = RouteStop.find(params[:id])
    
    if !route_stop_pending_destroy
      flash[:error] = "Couldn't find a stop for '#{params[:id]}"
      redirect_to
    end
    
    stop_links_to_remove = StopLink.where(route_stop: route_stop_pending_destroy)
    
    # We might not need this, but get it anyway
    new_route_stop_origin = RouteStop.where("idx = #{route_stop_pending_destroy.idx + 1}")
    
    if new_route_stop_origin
      stop_links_to_remove.each do |stop_link_to_remove|
        # If the link we're deleting is the same as its origin
        # then update all of the others to a new origin
        if stop_link_to_remove.origin_stop_link = stop_link_to_remove
          new_origin_stop_link = StopLink.where("origin_stop_link_id = #{stop_link_to_remove.id} and time != #{stop_link_to_remove.time}").order("time ASC").take
          if new_origin_stop_link
            StopLink.where("origin_stop_link_id = #{stop_link_to_remove.id}").update_all("origin_stop_link_id = #{new_origin_stop_link.id}")
          end
        end
      end
    end
    
    route_stop_pending_destroy.destroy
    # Negate the indexes as they might be like 0,1,3,4
    RouteStop.where("route_id = #{route_stop_pending_destroy.route_id} and idx > #{route_stop_pending_destroy.idx}").update_all("idx = idx - 1")
    # Destroy all related stop links
    StopLink.destroy_all(route_stop_id: route_stop_pending_destroy.id)
    
    flash[:success] = "Successfully deleted an occurrence of '#{route_stop_pending_destroy.stop.name}' on route '#{route_stop_pending_destroy.route.name}' at index '#{route_stop_pending_destroy.idx}'"

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