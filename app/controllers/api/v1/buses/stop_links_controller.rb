class Api::V1::Buses::StopLinksController < ApplicationController

  def destroy_stop_link_chain
    stop_links = StopLink.where('origin_stop_link_id = ?', params[:origin_stop_link_id])
    if stop_links.count == 0
      flash[:error] = "No stop links in the specified chain"
      redirect_to 'index'
    end
    
    if StopLink.where('origin_stop_link_id = ?', params[:origin_stop_link_id]).destroy_all
      flash[:success] = "Successfully deleted all stop links with origin of '#{param[:origin_stop_link_id]}"
    else
      flash[:error] = "Couldn't delete stop links"
    end
    redirect_to '/'
  end
  
  def edit
    # Fake it. In this case 'id' is equal to 'origin_stop_link_id'
    @stop_links = StopLink.where('origin_stop_link_id = ?', params[:id]).order_by(:time)
    if @stop_links = nil || @stop_links.count == 0
      flash[:error] = "No stop links with the origin id of '#{params[:origin_stop_link_id]}' found"
      redirect_to '/'
    end
    
    respond_to do |format|
      format.html
      format.xml
    end
  end
  
  def show
    
    @stop_links = StopLink.where('origin_stop_link_id = ?', params[:id]).order(:time)
    
    if @stop_links.count == 0
      flash[:error] = "Error"
      redirect_to '/'
    end
    
    @route = @stop_links[0].route_stop.route
    @timetable = @route.timetable
    
    respond_to do |format|
      format.html
      format.xml
    end
    
  end
  
  def create
    
    
    
  end
  
  def update
    @stop_links = params[:stop_links]
    
    @stop_links.each do |sl|
      stoplink = StopLink.find(sl[1]["id"])
      
      if stoplink == nil
        flash[:error] = "Couldn't find  stop link"
      else
        stoplink.time = sl[1]["time"].gsub(':', '')
        if !stoplink.save
          flash[:error] = "Couldn't save a stop link - #{stoplink.errors.full_messages}"
        end
      end
    end
    
    redirect_to api_v1_buses_timetable_route_path(params[:timetable_start_date], params[:route_id])
  end
end