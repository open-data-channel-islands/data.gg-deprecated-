class Api::V1::Buses::ExceptionsController < ApplicationController
  before_action :set_stop_link_exception, only: [:show, :edit, :update, :destroy]

  # GET /stop_link_exceptions
  # GET /stop_link_exceptions.json
  def index
    @stop_link_exceptions = StopLinkException.all
  end

  # GET /stop_link_exceptions/1
  # GET /stop_link_exceptions/1.json
  def show
  end

  # GET /stop_link_exceptions/new
  def new
    @stop_link_exception = StopLinkException.new
  end

  # GET /stop_link_exceptions/1/edit
  def edit
  end

  # POST /stop_link_exceptions
  # POST /stop_link_exceptions.json
  def create
    @stop_link_exception = StopLinkException.new(stop_link_exception_params)

    respond_to do |format|
      if @stop_link_exception.save
        format.html { redirect_to api_v1_buses_exception_url(@stop_link_exception), notice: 'Stop link exception was successfully created.' }
        format.json { render action: 'show', status: :created, location: @stop_link_exception }
      else
        format.html { render action: 'new' }
        format.json { render json: @stop_link_exception.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stop_link_exceptions/1
  # PATCH/PUT /stop_link_exceptions/1.json
  def update
    respond_to do |format|
      if @stop_link_exception.update(stop_link_exception_params)
        format.html { redirect_to api_v1_buses_exception_url(@stop_link_exception), notice: 'Stop link exception was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @stop_link_exception.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stop_link_exceptions/1
  # DELETE /stop_link_exceptions/1.json
  def destroy
    @stop_link_exception.destroy
    respond_to do |format|
      format.html { redirect_to api_v1_buses_exceptions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stop_link_exception
      @stop_link_exception = StopLinkException.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stop_link_exception_params
      params.require(:stop_link_exception).permit(:name, :colour)
    end
end
