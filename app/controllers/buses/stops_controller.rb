class Buses::StopsController < ApplicationController
  
  before_action :set_stop, :authenticate_user!
  
  # POST /stops
  # POST /stops.json
  def create
    @stop = Stop.new(stop_params)
    
    respond_to do |format|
      if @stop.save
        format.html { redirect_to buses_timetable_path(:start_date => @stop.timetable.start_date) + '#stops', notice: 'Stop was successfully created.' }
        format.json { render action: 'show', status: :created, location: @stop }
      else
        format.html { render action: 'new' }
        format.json { render json: @stop.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /stops/new
  def new
    @stop = Stop.new
  end
  
  # GET /stops/1/edit
  def edit
  end
  
  # PATCH/PUT /stops/1
  # PATCH/PUT /stops/1.json
  def update
    respond_to do |format|
      if @stop.update(stop_params)
        format.html { redirect_to buses_timetable_path(params[:timetable_start_date]), notice: 'Stop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @stop.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /stops/1
  # DELETE /stops/1.json
  def destroy
   @stop.destroy
   respond_to do |format|
     format.html { buses_timetable_url(:start_date => @stop.timetable.start_date) + '#stops' }
     format.json { head :no_content }
   end
  end
  
  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_stop
      @stop = Stop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stop_params
      params.require(:stop).permit(:timetable_id, :name, :latitude, :longitude)
    end
end