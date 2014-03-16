class Buses::RoutePeriodsController < ApplicationController
  
  def show
    
    timetable_date = params[:start]
    route_period_id = params[:id]
    
    @route_period = RoutePeriod.select(route_period_id)
    @timetable = Timetable.where(:start => timetable_date).first
    
    respond_to do |format|
      format.json { render json: @route_period }
      format.xml { render xml: @route_period }
      format.html { render html: @route_period }
    end
    
  end
  
  
  def create
    
    @route_period = RoutePeriod.new(route_period_params)
    
    respond_to do |f|
      if @route_period.save
        f.html { redirect_to buses_timetable_path(@route_period.route_overview.timetable), notice: 'Period successfully created' }
      else
        f.html { redirect_to buses_timetable_path(@route_period.route_overview.timetable), notice: "Couldn't create period" }
      end
    end
    
  end
  
  private
  
  def route_period_params
    params.require(:route_period).permit(:route_overview_id, :name, :start_day, :end_day)
  end
  
end
