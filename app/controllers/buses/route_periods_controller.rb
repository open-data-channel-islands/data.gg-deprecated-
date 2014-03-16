class Buses::RoutePeriodsController < ApplicationController
  
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
  
  def route_period_params
    params.require(:route_period).permit(:route_overview_id, :name, :start_day, :end_day)
  end
  
end
