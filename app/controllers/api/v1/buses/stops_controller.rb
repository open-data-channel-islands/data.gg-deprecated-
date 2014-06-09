class Api::V1::Buses::StopsController < ApplicationController
  
  before_action :authenticate_user!
  
  def create
    stop = Stop.new(stop_params)
    if !stop.save
      flash[:error] = "Couldn't create stop: " + stop.errors.full_messages[0]
    else
      flash[:success] = "Stop '#{stop.name}' successfully created"
    end
    
    redirect_to api_v1_buses_timetable_path(:start_date => stop.timetable.start) + '#stops'
  end
  
  def edit
    
    @stop = Stop.find(params[:id])
    @timetable = @stop.timetable

    if @stop == nil
      # TODO: Do something...
    end
    
  end
  
  def update
    @stop = Stop.find params[:id]
    
    if @stop.update_attributes stop_params
      flash[:success] = "Successfully updated stop"
    else
      flash[:error] = "Error updating stop: " + @stop.errors.full_messages[0]
    end
    
    
    redirect_to api_v1_buses_timetable_path(params[:timetable_start_date])
  end
  
  def destroy
    stop = Stop.find(params[:id])
    # Get rid of 'em?
   # RouteStop.where(:stop_id => params[:id]).delete_all
    
    if stop.destroy
      flash[:success] = "Stop '#{stop.name}' has been deleted"
    else
      flash[:error] = "Stop '#{stop.name}' couldn't be deleted"
    end
    
    redirect_to api_v1_buses_timetable_path(:start_date => stop.timetable.start) + '#stops'
  end
  
  private
  
  def stop_params
    params.require(:stop).permit(:timetable_id, :name, :latitude, :longitude)
  end
end