class BusesController < ApplicationController
  
  def index
    
  end
  
  def data
    # Timetable (top-level with a 'from' data. Also needs 'revision')
    #  Route
    #   Stop
    
    
    @routes = Route.all
    
    respond_to do |format|
      format.html
      format.json
      format.xml
    end
  end
  
end
