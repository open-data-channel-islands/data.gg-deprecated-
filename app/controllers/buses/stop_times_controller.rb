class Buses::StopTimesController < ApplicationController

  before_action :authenticate_user!, :except => [:show]
  before_action :set_stop_time, :except => [:remove_exception ]
  
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
    @stop_time = StopTime.find(params[:id])
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
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stop_time
      @stop_time = StopTime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exception_params
      params.require(:stop_time_exception).permit(:time, :skip, :night)
    end
  
end