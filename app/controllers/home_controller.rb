#require './lib/live_data_sets'
#require './lib/sailings_parser'
require 'xml_parser'

class HomeController < ApplicationController
  layout "application", :only => [ :about, :help ]
  before_action :set_data_categories, only: [:index, :developers, :charts]

  def index
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
    @data_categories = DataCategory.where("show_on_website = true").order(:coming_soon, :created_at)
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
