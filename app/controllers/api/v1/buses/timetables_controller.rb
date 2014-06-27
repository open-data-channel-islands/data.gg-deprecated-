require 'date'
require './lib/data_path_resolver'

class Api::V1::Buses::TimetablesController < ApplicationController
  
  before_action :set_timetable, :except => [:list]
  before_action :authenticate_user!, :except => [:show, :current_version, :list]
  
  def show
    if user_signed_in?
      template = 'show_admin'
    else
      template = 'show'
    end
    
    @route = Route.new
    @stop = Stop.new

    respond_to do |format|
      format.json { render json: @timetable.to_json(:include => {
        :routes => { :include => {
          :route_stops => {},
          :stop_times => {}
        }},
        :stops => {}
      })}
      format.xml { render :xml => @timetable.to_xml(:skip_types => true, :except => :created_at, :include => {
        :routes => { :except => :created_at, :include => {
          :route_stops => {},
          :stop_times => {}
        }},
        :stops => { :except => [:created_at] }
      })}
      format.html { render template }
    end
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @timetable.update(timetable_params)
        format.html { redirect_to api_v1_buses_timetable_path(@timetable.start_date), notice: 'Timetable was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @timetable.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def list
    @timetables = Timetable.order(:start_date).all
    
    # Dirty hack, but the models have no idea about the HTTP context
    # so we need to hand it over before rendering the output
    root_url = "#{request.protocol}#{request.host_with_port}"
    @timetables.each do |t|
      t.root_url = root_url
    end
    
    respond_to do |format|
      format.xml { render :xml => @timetables.to_xml(methods: [:xml_download_url, :json_download_url, :xml_download_url_compressed, :json_download_url_compressed], except: [:created_at, :updated_at]) }
      format.json { render :json => @timetables.to_json(methods: [:json_download_url, :json_download_url, :json_download_url_compressed], only: [:id, :name, :start_date, :end_date, :current_version]) }
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
            :stop_times => {
              :except => [:created_at, :updated_at],
              :include => { 
                :stop_time_exceptions => { :except => [:created_at, :updated_at] }
              } 
            }
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
            :stop_times => {
              :except => [:created_at, :updated_at],
              :include => { 
                :stop_time_exceptions => { :except => [:created_at, :updated_at] }
              } 
            }
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
    @timetable = Timetable.new(timetable_params)
    
    respond_to do |format|
      if @timetable.save
        format.html { redirect_to api_v1_buses_timetable_path(:start_date => @timetable.start_date) + '#stops', notice: "Timetable '#{@timetable.name}' was successfully created." }
        format.json { render action: 'show', status: :created, location: @timetable }
      else
        format.html { render action: 'new' }
        format.json { render json: @timetable.errors, status: :unprocessable_entity }
      end
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
  
    # Use callbacks to share common setup or constraints between actions.
    def set_timetable
      @timetable = Timetable.where(start_date: params[:start_date]).take!
    end
  
    def timetable_params
      params.require(:timetable).permit(:name, :description, :start_date, :end_date)
    end
end