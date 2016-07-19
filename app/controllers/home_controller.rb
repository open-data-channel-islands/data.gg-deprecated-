require './lib/live_data_sets'
require 'xml_parser'

class HomeController < ApplicationController
  layout "application", :only => [ :about, :help ]
  before_action :set_data_categories, only: [:index, :developers, :charts]

  def index
    colors = [
      ["rgba(255, 240, 110, 0.5)", "rgba(193, 186, 123, 0.5)"],
    ["rgba(187, 255, 147, 0.5)", "rgba(87, 149, 50, 0.5)"],
    ["rgba(147, 255, 220, 0.5)", "rgba(38, 113, 88, 0.5)"],
    ["rgba(255, 183, 147, 0.5)", "rgba(170, 95, 57, 0.5)"],
    ["rgba(255, 147, 172, 0.5)", "rgba(156, 52, 76, 0.5)"],
    ["rgba(147, 187, 255, 0.5)", "rgba(38, 87, 149, 0.5)"]
    ]

    bus_usage_json = File.read("storage/#{ENV['place_code']}/buses/bus_usage.json")
    bus_usage = JSON.parse(bus_usage_json)

    @years = bus_usage.uniq { |p| p['Year'] }.collect { |p| p['Year'] }

    # Months for looping over data
    month_itter = ['January','February','March','April','May',
      'June','July','August','September','October','November','December']

    # Create a hash so you have bus_usage[year] containing an array of key-value pairs for month->value
    bus_usage = Hash[*bus_usage.map { |k| [k['Year'], k] }.flatten]

    @bus_data = []

    @years.each do |year|
      values = []
      curr_usage = bus_usage[year]

      month_itter.each do |month|
        val = curr_usage[month]
        # Only show it if it exists
        if val != nil
          values << val
        else
          values << 0
        end
      end

      color = colors[colors.length - 1]
      colors.delete_at(colors.length - 1)
      @bus_data << { name: year, data: values, color: color[0], borderColor: color[1] }
    end

    @active_alerts = Alert.where(active: true).order(created_at: :desc)

    respond_to do |format|
      format.json
      format.xml
      format.html
    end

  end

  def contact

  end

  def about

  end

  def help

  end

  def developers

  end

  def charts
  end

  def developers_data_category
    @data_category = DataCategory.where("stub = ?", params[:data_category]).first
    @data_sets = @data_category.data_sets.joins(:place).where("places.code = ?", ENV['place_code'].upcase)
  end

  def api
    @data_category = DataCategory.where("stub = ?", params[:data_category]).first
    @data_set = DataSet.joins(:place).where("stub = ? AND places.code = ? AND data_category_id = ?",
      params[:data_set], ENV['place_code'].upcase, @data_category.id).first

    # Live data is got from LiveDataSets in lib. The filename is set to the method name
    # .send(...) calls a method via name.
    if @data_set.live?
      @data = LiveDataSets.send(@data_set.filename)
    else
      json = File.read("storage/#{ENV['place_code']}/#{@data_set.filename}")
      @data = JSON.parse(json)
    end

    respond_to do |format|
      format.json { render json: @data }
      format.xml { @data }
      format.html { render :api, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def sitemap
    set_data_categories
    @data_sets = DataSet.all
    respond_to do |format|
      format.xml
    end
  end

  private

  def set_data_categories
    @data_categories = DataCategory.all
    @chart_categories = []
    @data_categories.each do |data_category|
      if path_exists? '/charts/' + data_category.stub
        @chart_categories << data_category
      end
    end
  end

  def path_exists?(path)
    begin
      Rails.application.routes.recognize_path(path)
    rescue
      return false
    end
    true
  end
end
