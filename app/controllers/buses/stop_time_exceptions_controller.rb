class Buses::StopTimeExceptionsController < ApplicationController
  before_action :set_stop_time_exception, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:create, :edit, :update, :destroy]

  # GET /exceptions
  # GET /exceptions.json
  def index
    @stop_time_exceptions = StopTimeException.all
  end

  # GET /exceptions/1
  # GET /exceptions/1.json
  def show
  end

  # GET /exceptions/new
  def new
    @stop_time_exception = StopTimeException.new
  end

  # GET /exceptions/1/edit
  def edit
  end

  # POST /exceptions
  # POST /exceptions.json
  def create
    @stop_time_exception = StopTimeException.new(exception_params)

    respond_to do |format|
      if @stop_time_exception.save
        format.html { redirect_to buses_exception_url(@stop_time_exception), notice: 'Exception was successfully created.' }
        format.json { render action: 'show', status: :created, location: @stop_time_exception }
      else
        format.html { render action: 'new' }
        format.json { render json: @stop_time_exception.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exceptions/1
  # PATCH/PUT /exceptions/1.json
  def update
    respond_to do |format|
      if @stop_time_exception.update(exception_params)
        format.html { redirect_to buses_exception_url(@stop_time_exception), notice: 'Exception was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @stop_time_exception.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exceptions/1
  # DELETE /exceptions/1.json
  def destroy
    @stop_time_exception.destroy
    respond_to do |format|
      format.html { redirect_to buses_stop_time_exceptions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stop_time_exception
      @stop_time_exception = StopTimeException.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exception_params
      params.require(:stop_time_exception).permit(:name, :colour)
    end
end
