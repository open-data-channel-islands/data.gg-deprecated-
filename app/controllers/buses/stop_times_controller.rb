class Buses::StopTimesController < ApplicationController

  before_action :authenticate_user!, :except => [:show]
  before_action :set_stop_time, :except => [:remove_exception, :update, :new, :create]
  
  def edit
  end
  
  def show
    if user_signed_in?
      if @stop_time.stop_time_exceptions.count > 0
        @exceptions = StopTimeException.find(:all, :conditions => ['id not in (?)', @stop_time.stop_time_exceptions.map(&:id)])
      else
        @exceptions = StopTimeException.all
      end
      
      template = 'show_admin'
    else
      template = 'show'
    end
    
    respond_to do |format|
      format.html { render action: template }
      format.xml
    end
  end
  
  def destroy
    if @stop_time.origin_stop_time != @stop_time
      # TODO: Redirect, we shouldn't be allowed to destroy individual ones, only origins. The deletion cascades.
    else
      @stop_time.destroy
      respond_to do |format|
        format.html { redirect_to buses_timetable_route_path(timetable_start_date: @stop_time.route.timetable.start_date, route_id: @stop_time.route.id) }
        format.json { head :no_content }
      end
    end
  end
  
  def add_exception
    @stop_time = StopTime.find(params[:stop_time_id])
    @exception = StopTimeException.find(params[:stop_time_exception][:id])
    @stop_time.stop_time_exceptions << @exception
    
    respond_to do |format|
      if @stop_time.save
        format.html { redirect_to buses_timetable_route_path(@stop_time.route.timetable.start_date, @stop_time.route.id), notice: 'Exception added' }
      else
        
      end
    end
  end
  
  def remove_exception
    @stop_time_exception = StopTimeException.find(params[:stop_time_exception_id])
    @stop_time = StopTime.find(params[:stop_time_id])
    
    respond_to do |format|
      if @stop_time.stop_time_exceptions.delete(@stop_time_exception)
        format.html { redirect_to buses_timetable_route_path(@stop_time.route.timetable.start_date, @stop_time.route.id), success: 'Exception removed' }
      else
        
      end
    end
  end
  
  def new
    @route = Route.find(params[:route_id])
    @route_stops = RouteStop.where(route_id: params[:route_id])
    @stop_times = Array.new
    @route_stops.each do |route_stop|
      stop_time = StopTime.new
      stop_time.route_stop = route_stop
      stop_time.night = false
      stop_time.skip = false
      stop_time.route = @route
      @stop_times << stop_time
    end
  end
  
  # POSTed from the timetables 'show'
  def create
    @route = Route.find(params[:route_id])
    
    stop_times = Array.new
    params[:stop_times].each do |stop_time|
      st = StopTime.new
      st.time = stop_time[1]["time"].gsub(':', '')
      st.night = stop_time[1]["night"]
      st.skip = stop_time[1]["skip"]
      st.route = @route
      st.route_stop_id = stop_time[1]["route_stop_id"]
      stop_times << st
    end
    
    # Transaction-based DB. This works a treat. A much simpler
    # approach to it.
    StopTime.transaction do
      stop_times.each do |st|
        st.save!
        # We don't have the origin ID until now
        st.origin_stop_time_id = stop_times[0].id
        # Need to save it again to save the origin
        st.save!
      end
    end
    
    respond_to do |format|
      format.html { redirect_to buses_timetable_route_path(@route.timetable.start_date, @route.id), success: 'Exception removed' }
    end
  end
  
  def edit_individual
    @exceptions = StopTimeException.all
  end
  
  # This always updates a collection
  def update
    @stop_times = params[:stop_times]
    
    # TODO: Use a transaction for this, too
    StopTime.transaction do
      @stop_times.each do |stop_time|
        db_stop_time = StopTime.find(stop_time[1]["id"])
      
        unless db_stop_time.nil?
          db_stop_time.update_attributes stop_time[1]
        end
      end
    end
    
    redirect_to buses_timetable_route_path(params[:timetable_start_date], params[:route_id])  
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stop_time
      @stop_time = StopTime.find(params[:stop_time_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exception_params
      params.require(:stop_time_exception).permit(:time, :skip, :night)
    end
  
end