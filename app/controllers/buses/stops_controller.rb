class Buses::StopsController < ApplicationController
  
  def index
    @stops = Stop.all
    
    respond_to do |format|
      format.html
    end
  end
  
  def show
    
  end
end