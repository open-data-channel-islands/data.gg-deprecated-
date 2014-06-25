class Api::V1::Buses::RoutesController < ApplicationController
  
  before_action :authenticate_user!, :except => [:show]
  
  # POSTed from the timetables 'show'
  def create
    route = Route.new(route_params)
    
    if route.save
      flash[:success] = "Route '#{route.name}' created"
      redirect_to api_v1_buses_timetable_path(:start_date => route.timetable.start_date)
    else
      flash[:error] = "Route '#{route.name}' could not be created"
      redirect_to api_v1_buses_timetable_path(:start_date => route.timetable.start_date)
    end
  end
  
  def edit
    @timetable = Timetable.where(:start_date => params[:timetable_start_date]).first
    
    @route = Route.where(:id => params[:id]).first
    
    if @route == nil
      redirect_to api_v1_buses_path
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
    
    redirect_to api_v1_buses_timetable_route_path(@route.timetable.start_date, @route.id)
  end
  def destroy
    route = Route.find_by_id(params[:id])
    
    if route.destroy
      flash[:success] = "Route #{route.name} destroyed"
      redirect_to api_v1_buses_timetable_path(params[:timetable_start_date])
    else
      flash[:error] = "Couldn't delete #{route.name}"
      redirect_to api_v1_buses_timetable_route_path(:timetable_start_date => params[:start], :id => params[:id])
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
      sl = StopTime.new
      sl.route_stop = route_stop
      if @new_stop_link_set.count > 0
        sl.origin_stop_link = @new_stop_link_set[0]
      else
        sl.origin_stop_link = sl
      end
      
      @new_stop_link_set << sl
      
    end
    
    @ordered_route_stops = @route.route_stops.order(:idx).all

    tmp_stop_links = StopTime.joins("INNER JOIN route_stops rs ON rs.id = stop_times.route_stop_id")
                          .joins("INNER JOIN stop_times origin ON origin.origin_stop_link_id = stop_times.origin_stop_link_id")
                          .where("rs.route_id = ?", @route.id)
                          .select("DISTINCT ON (stop_times.origin_stop_link_id, origin.time, origin.id, rs.idx) stop_times.origin_stop_link_id, rs.route_id, origin.time, stop_times.id, rs.idx, stop_times.time")
                          .order("stop_times.origin_stop_link_id, origin.time ASC, origin.id ASC, rs.idx ASC")
    overall_set = Array.new # Contains ALL the stop links
    curr_set = Array.new # Contains CURRENT set
    curr_origin = nil
    tmp_stop_links.each do |stop_link|
      
      if curr_origin != nil && curr_origin != stop_link.origin_stop_link.id
        overall_set << curr_set
        curr_set = Array.new
      end
      
      curr_origin = stop_link.origin_stop_link.id
      curr_set << stop_link
    end
    
    # because the LAST set won't flip over, so need to push it on
    if curr_set.length > 0
      overall_set << curr_set
      @stop_links = overall_set
    else
      @stop_links = Array.new
    end
                        
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