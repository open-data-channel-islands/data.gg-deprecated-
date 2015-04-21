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

  def rpi_group_changes
    inflation_json = File.read("storage/inflation/rpi_group_changes.json")
    @group_changes = JSON.parse(inflation_json)
    @title = 'RPI Group Changes'

    respond_to do |format|
      format.json { render json: @group_changes }
      format.xml { render xml: @group_changes }
      format.html { render :group_changes, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def rpix_group_changes
    inflation_json = File.read("storage/inflation/rpix_group_changes.json")
    @group_changes = JSON.parse(inflation_json)
    @title = 'RPIX Group Changes'

    respond_to do |format|
      format.json { render json: @group_changes }
      format.xml { render xml: @group_changes }
      format.html { render :group_changes, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end
end
