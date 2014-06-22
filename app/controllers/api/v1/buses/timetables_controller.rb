require 'date'
require './lib/data_path_resolver'

class Api::V1::Buses::TimetablesController < ApplicationController
  
  before_action :authenticate_user!, :except => [:show, :current_version, :list]
  
  def show
    if user_signed_in?
      template = 'show_admin'
    else
      template = 'show'
    end
    
    @timetable = Timetable.where(start_date: params[:start_date]).first
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
      format.xml { render :xml => @timetable.to_xml(:skip_types => true, :except => :created_at, :include => {
        :routes => { :except => :created_at, :include => {
          :route_stops => {},
          :stop_links => {}
        }},
        :stops => { :except => [:created_at] }
      })}
      format.html { render template }
    end
  end
  
  def edit
    @timetable = Timetable.where(start_date: params[:start_date]).first
    
    if @timetable == nil
      flash[:error] = "No timetable found with the start date '#{params[:start_date]}'"
      redirect_to api_v1_buses_timetables_path
    end
  end
  
  def update
    @timetable = Timetable.find params[:timetable][:id]
    
    if @timetable.update_attributes timetable_params
      flash[:success] = "Successfully updated timetable"
    else
      flash[:error] = "Error updating stop: " + @timetable.errors.full_messages[0]
    end
    
    redirect_to api_v1_buses_timetable_path(@timetable.start_date)
  end
  
  def data
    respond_to do |format|
      format.xml { send_file("#{Rails.root}" + Timetable.filename(params[:timetable_start_date], params[:version], 'xml', false),
                      file_name: Timetable.name + '.xml.tar.gz', type: 'application/zip', :x_sendfile => true) }
      format.json { send_file("#{Rails.root}" + Timetable.filename(params[:timetable_start_date], params[:version], 'json', false),
                      file_name: Timetable.name + '.json.tar.gz', type: 'application/zip', :x_sendfile => true) }
    end
    # This should a) check if the file exists, b) if it doesn't then generate and c) download it
  end
  
  def data_compressed
    respond_to do |format|
      format.xml { send_file("#{Rails.root}" + Timetable.filename(params[:timetable_start_date], params[:version], 'xml', true),
                      file_name: Timetable.name + '.xml.tar.gz', type: 'application/zip', :x_sendfile => true) }
      format.json { send_file("#{Rails.root}" + Timetable.filename(params[:timetable_start_date], params[:version], 'json', true),
                      file_name: Timetable.name + '.json.tar.gz', type: 'application/zip', :x_sendfile => true) }
    end
  end
  
  def list
    @timetables = Timetable.order(:start_date).all
    
    respond_to do |format|
      format.xml { render :xml => @timetables.to_xml(:only => [:id, :name, :start_date, :end, :current_version]) }
      format.json { render :json => @timetables.to_json(:only => [:id, :name, :start_date, :end, :current_version])  }
    end
  end
  
  def current_version
    now = Time.now
    @current_timetable = Timetable.where("(? > start_date) AND (end_date IS NULL OR (end_date > ?))", now, now).order(:start_date).first
    
    respond_to do |format|
      format.xml { render :xml => @current_timetable.to_xml(:only => [:start_date, :current_version]) }
      format.json { render :json => @current_timetable.to_json(:only => [:start_date, :current_version]) }
    end
  end
  
  
  # Increments the current_version and then writes the data to file
  def publish

    timetable = Timetable.where(:start_date => params[:timetable_start_date]).take!
    timetable.current_version = timetable.current_version + 1
    if timetable.save
      
      path = DataPathResolver.buses_path(true) # is a writable path
      
      # Write out JSON file
      json_filename = timetable.filename('json')
      json_file = File.new(json_filename, 'w')
      json_file.write(timetable.to_json(
        :except => [:created_at, :updated_at],
        :include => {
        :routes => {
          :except => [:created_at, :updated_at],
          :include => {
            :route_stops => { :except => [:created_at, :updated_at] },
            :stop_links => { :except => [:created_at, :updated_at] }
          }
        },
        :stops => { :except => [:created_at, :updated_at] }
      }))
      json_file.flush
      
      # Write out XML file
      xml_filename = timetable.filename('xml')
      xml_file = File.new(xml_filename, 'w')
      xml_file.write(timetable.to_xml(
        :except => [:created_at, :updated_at],
        :include => {
        :routes => {
          :except => [:created_at, :updated_at],
          :include => {
            :route_stops => { :except => [:created_at, :updated_at] },
            :stop_links => { :except => [:created_at, :updated_at] }
          }
        },
        :stops => { :except => [:created_at, :updated_at] }
      }))
      xml_file.flush
      
      # TODO: Use this for paths instead: http://stackoverflow.com/questions/3724487/rails-root-directory-path
      json_name = Pathname.new(json_filename).basename
      xml_name = Pathname.new(xml_filename).basename
      
      if system("cd #{path} && tar -czf #{json_name}.tar.gz #{json_name} && tar -czf #{xml_name}.tar.gz #{xml_name}")
        flash[:success] = "Timetable '#{params[:timetable_start_date]}' published into '#{path}. Current version number is '#{timetable.current_version}'"
      else
        flash[:error] = "Couldn't fully publish timetable '#{params[:timetable_start_date]}' into '#{path}'"
      end
    else
      flash[:error] = "Couldn't update timetable"
    end
    
    redirect_to api_v1_buses_timetable_path(:start_date => params[:timetable_start_date])
  end
  
  
  def create
    timetable = Timetable.new(timetable_params)
    
    # TODO: Check for timetable overlaps!
    
    if timetable.save
      flash[:success] = "Timetable '#{timetable.name}' successfully saved."
      redirect_to api_v1_buses_timetable_path(timetable.start_date)
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
    params.require(:timetable).permit(:name, :description, :start_date, :end)
  end
end