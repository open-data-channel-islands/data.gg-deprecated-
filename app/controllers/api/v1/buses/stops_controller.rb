class Api::V1::Buses::StopsController < ApplicationController
  
  def index
    @stops = Stop.all
    @stop = Stop.new
    
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @stop = Stop.new(stop_params)
    if !@stop.save
      flash[:error] = "Couldn't save"
    end
    
    redirect_to api_v1_buses_timetable_path(:start_date => @stop.timetable.start) + '#stops'
  end
  
  def destroy
      @stop = Stop.find(params[:id])
      @stop.destroy

      respond_to do |format|
        format.html { redirect_to buses_stops_path }
        format.xml  { head :ok }
      end
    end
  
  def new
    
    @stop = Stop.new
    
    respond_to do |format|
      format.html
    end
    
  end
  
  def show
    
  end
  
  private
  
  def stop_params
    params.require(:stop).permit(:timetable_id, :name, :latitude, :longitude)
  end
end