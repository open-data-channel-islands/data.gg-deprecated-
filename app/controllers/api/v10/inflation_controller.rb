class Api::V10::InflationController < ApplicationController
  def changes
    inflation_json = File.read("storage/inflation/changes.json")
    @changes = JSON.parse(inflation_json)

    respond_to do |format|
      format.json { render json: @changes }
      format.xml { render xml: @changes }
      format.html { render :changes, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end
end
