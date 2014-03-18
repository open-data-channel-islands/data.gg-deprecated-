class Api::V1::Buses::ApiController < ApplicationController
  
  # This controller should allow QUERIES on the data.
  # The download currently happens from the timetables_controller
  
  def latest
    format = params[:format]
    send_data '/assets/data/{0}'
  end
  
end