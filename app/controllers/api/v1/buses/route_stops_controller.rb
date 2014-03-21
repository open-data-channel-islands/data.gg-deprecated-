class Api::V1::Buses::RouteStopsController < ApplicationController
  
  def create
    @route_stop = RouteStop.new(route_stop_params)

    # This gets the very first route_stop instance
    rs = RouteStop.where(route_id: @route_stop.route.id).order(:idx).first()
    idx = 0
    print idx
    if rs
      idx = rs.idx
    end
    
    print idx
    
    @route_stop.idx = idx + 1

    respond_to do |f|
      if @route_stop.save
        flash[:success] = "Success"
        redirect_to api_v1_buses_timetable_route(@route_stop.route.timetable.start, @route_stop.id)
      else
        flash[:error] = "Fail"
        print @route_stop.errors.full_messages
        redirect_to "/"
      end
    end
  end
  
  def create_stop_links
    
    
    respond_to do |f|
      
    end
  end
  
  private
  
  def route_stop_params
    params.require(:route_stop).permit(:stop_id, :route_id)
  end
  
  def route_params
    params.permit(:route_id)
  end
  
end