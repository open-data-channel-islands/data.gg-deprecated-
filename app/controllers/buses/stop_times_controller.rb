class Buses::StopTimesController < ApplicationController

  def destroy_stop_link_chain
    stop_links = StopTime.where('origin_stop_link_id = ?', params[:origin_stop_link_id])
    if stop_links.count == 0
      flash[:error] = "No stop links in the specified chain"
      redirect_to 'index'
    end
    
    if StopTime.where('origin_stop_link_id = ?', params[:origin_stop_link_id]).destroy_all
      flash[:success] = "Successfully deleted all stop links with origin of '#{param[:origin_stop_link_id]}"
    else
      flash[:error] = "Couldn't delete stop links"
    end
    redirect_to '/'
  end
  
  def edit
    # Fake it. In this case 'id' is equal to 'origin_stop_link_id'
    @stop_times = StopTime.where('origin_stop_link_id = ?', params[:id]).order_by(:time)
    if @stop_times = nil || @stop_times.count == 0
      flash[:error] = "No stop links with the origin id of '#{params[:origin_stop_link_id]}' found"
      redirect_to '/'
    end
    
    respond_to do |format|
      format.html
      format.xml
    end
  end
  
  def show
    
    @stop_times = StopTime.where('origin_stop_link_id = ?', params[:id]).order(:time)
    
    if @stop_times.count == 0
      flash[:error] = "Error"
      redirect_to '/'
    end
    
    @route = @stop_times[0].route_stop.route
    @timetable = @route.timetable
    
    respond_to do |format|
      format.html
      format.xml
    end
    
  end
  
  def atomic_stop_time
    @stop_time = StopTime.find(params[:id])
    @stop_time_exception = StopTimeException.new
    @exceptions = StopTimeException.all
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
  
  def update
    @stop_times = params[:stop_links]
    
    success = true
    
    @stop_times.each do |sl|
      stop_time = StopTime.find(sl[1]["id"])
      
      if stop_time == nil
        success = false
        flash[:error] = "Couldn't find stop time"
      else
        stop_time.time = sl[1]["time"].gsub(':', '')
        stop_time.skip = sl[1]["skip"]
        stop_time.night = sl[1]["night"]
        if !stop_time.save
          success = false
          flash[:error] = "Couldn't save a stop time - #{stop_time.errors.full_messages}"
        end
      end
    end
    
    if success
      flash[:success] = "Successfully saved links!"
    end
    
    redirect_to buses_timetable_route_path(params[:timetable_start_date], params[:route_id])
  end
end