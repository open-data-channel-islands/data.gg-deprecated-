class Buses::StopsController < ApplicationController
  
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
    
    redirect_to buses_stops_path
  end
  
  def show
    
  end
  
  private
  
  def stop_params
    params.require(:stop).permit(:name, :latitude, :longitude)
  end
end