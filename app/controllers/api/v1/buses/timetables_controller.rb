require 'date'

class Api::V1::Buses::TimetablesController < ApplicationController
  
  before_action :authenticate_user!, :except => [:show, :current_version]
  
  def show
    if user_signed_in?
      template = 'show_admin'
    else
      template = 'show'
    end
    
    @timetable = Timetable.where(:start => params[:start_date]).first
    @route = Route.new
    @stop = Stop.new

    respond_to do |format|
      format.json { render json: @timetable.to_json(:include => {
        :routes => { :include => {
          :route_stops => {},
          :stop_links => {}
        }},
        :stops => {}
      })}
      format.xml { render :xml => @timetable.to_xml(:include => {
        :routes => { :include => {
          :route_stops => {},
          :stop_links => {}
        }},
        :stops => {}
      })}
      format.html { render template }
    end
  end
  
  def list
    @timetables = Timetable.all.order_by("start")
    
    respond_to do |format|
      format.xml { render xml: @timetables }
      format.json { render json: @timetables }
    end
  end
  
  def current_version
    now = Time.now
    @current_timetable = Timetable.where("? > start and end > ?", now, now)
    
    respond_to do |format|
      format.xml { render :xml => @current_timetable.to_xml(:only => [:start, :current_version]) }
      format.json { render :json => @current_timetable.to_json(:only => [:start, :current_version]) }
    end
  end
  
  def publish
    
    #TODO: Increment current_version, if successful, write to file
    
    timetable = Timetable.where(:start => params[:start_date]).first
    timetable.current_version = timetable.current_version + 1
    if timetable.update!
      flash[:success] = "Timetable '#{params[:start_date]}' published! Current version number is '#{@timetable.current_version}'"
    else
      flash[:error] = "Couldn't update timetable"
    end
    
    redirect_to api_v1_buses_timetable_path(:start_date => params[:start_date])
  end
  
  def create
    timetable = Timetable.new(timetable_params)
    
    # TODO: Check for timetable overlaps!
    
    if timetable.save
      flash[:success] = "Timetable '#{timetable.name}' successfully saved."
      redirect_to api_v1_buses_timetable_path(timetable.start)
    else
      flash[:error] = "Error creating table: #{timetable.errors}"
      redirect_to api_v1_buses_path
    end
  end
  
  def destroy
    start_date = params[:start_date]
    timetable = Timetable.find_by_start(start_date)
    
    if !timetable
      flash[:error] = "Couldn't find a timetable with start date of '#{start_date}' to delete!"
      redirect_to api_v1_buses_path # redirect a level higher because it doesn't exist
    end
    
    if !timetable.destroy
      flash[:error] = "Couldn't delete the timetable with a start date of '#{start_date}'"
      redirect_to api_v1_buses_timetable_path(start_date)
    end
    
    flash[:success] = "Successfully deleted timetable with a start date of '#{start_date}'"
    redirect_to api_v1_buses_path
  end
  
  private
  
  def timetable_params
    params.require(:timetable).permit(:name, :description, :start, :end)
  end
end