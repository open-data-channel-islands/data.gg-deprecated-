class Buses::RouteOverviewsController < ApplicationController
  
  def create
    @overview = RouteOverview.new(route_overview_params)

    respond_to do |f|
      if @overview.save
        f.html { redirect_to buses_timetable_path(@overview.timetable), notice: 'Overview successfully created' }
      else
        f.html { redirect_to buses_timetable_path(@overview.timetable), notice: "Couldn't create overview" }
      end
    end
  end
  
  def route_overview_params
    params.require(:route_overview).permit(:timetable_id, :name)
  end
  
end
