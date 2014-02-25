class Buses::RoutesController < ApplicationController
  
  def create
    @route_stop = RouteStop.new(stop_params)
    @route = Route.find(params.permit(:route_id))
    
    if @route_stop.save
      flash[:error] = "Couldn't save"
      
      respond_to do |format|
        format.html
      end
    end
    
    flash[:success] = "Success"
    redirect_to "stops"
    
  end
  
  private
  
  def route_stop_params
    params.require(:route_stop).permit(:name, :latitude, :longitude)
  end
  
  def route_params
    params.permit(:route_id)
  end
  
end