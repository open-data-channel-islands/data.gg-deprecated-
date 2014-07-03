require 'date'
require './lib/data_path_resolver'

class Buses::TimetablesController < ApplicationController
  
  before_action :set_timetable, :except => [:create, :list, :publish]
  before_action :authenticate_user!, :except => [:show, :current_version, :list]
  
  def show
    if user_signed_in?
      template = 'show_admin'
    else
      template = 'show'
    end
    
    @route = Route.new
    @stop = Stop.new
    @stop_time_exception = StopTimeException.new
    @stop_time_exception.timetable_id = @timetable.id

    respond_to do |format|
      format.json { render json: @timetable.to_json(:include => {
        :routes => { :include => {
          :route_stops => {},
          :stop_times => {}
        }},
        :stops => {},
        :stop_time_exceptions => { :except => [:created_at, :updated_at] }
      })}
      format.xml { render :xml => @timetable.to_xml(:skip_types => true, :except => :created_at, :include => {
        :routes => { :except => [:created_at], :include => {
          :route_stops => {},
          :stop_times => {}
        }},
        :stops => { :except => [:created_at] },
        :stop_time_exceptions => { :except => [:created_at, :updated_at]}
      })}
      format.html { render action: template }
    end
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @timetable.update(timetable_params)
        format.html { redirect_to buses_timetable_path(@timetable.start_date), notice: 'Timetable was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @timetable.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  # Increments the current_version and then writes the data to file
  def publish
    # This one' sdifferent because of routing
    @timetable = Timetable.where(start_date: params[:timetable_start_date]).take!

    @timetable.current_version = @timetable.current_version + 1
    if @timetable.save
      
      path = DataPathResolver.buses_path(true) # is a writable path
      
      # Write out JSON file
      json_filepath = @timetable.filepath('json')
      json_file = File.new(json_filepath, 'w')
      json_file.write(@timetable.to_json(
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
      xml_filepath = @timetable.filepath('xml')
      xml_file = File.new(xml_filepath, 'w')
      xml_file.write(@timetable.to_xml(
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
      json_name = Pathname.new(json_filepath).basename
      xml_name = Pathname.new(xml_filepath).basename
      
      if system("cd #{path} && tar -czf #{json_name}.tar.gz #{json_name} && tar -czf #{xml_name}.tar.gz #{xml_name}")
        flash[:success] = "Timetable '#{params[:timetable_start_date]}' published into '#{path}. Current version number is '#{@timetable.current_version}'"
      else
        flash[:error] = "Couldn't fully publish timetable '#{params[:timetable_start_date]}' into '#{path}'"
      end
    else
      flash[:error] = "Couldn't update timetable"
    end
    
    redirect_to buses_timetable_path(:start_date => params[:timetable_start_date])
  end
  
  
  def create
    @timetable = Timetable.new(timetable_params)
    
    respond_to do |format|
      if @timetable.save
        format.html { redirect_to buses_timetable_path(:start_date => @timetable.start_date) + '#stops', notice: "Timetable '#{@timetable.name}' was successfully created." }
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
      redirect_to buses_path # redirect a level higher because it doesn't exist
    end
    
    if !timetable.destroy
      flash[:error] = "Couldn't delete the timetable with a start date of '#{start_date}'"
      redirect_to buses_timetable_path(start_date)
    end
    
    flash[:success] = "Successfully deleted timetable with a start date of '#{start_date}'"
    redirect_to buses_path
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