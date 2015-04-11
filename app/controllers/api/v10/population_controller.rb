class Api::V10::PopulationController < ApplicationController
  before_action :set_population

  def index
    respond_to do |format|
      format.html { render :index }
    end
  end

  def population
    respond_to do |format|
      format.json { render json: @population }
      # We use a template builder for this one as the data column names have numbers in them
      # and XML sucks.
      format.xml { @population }
      format.html { render :population, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  private

  def set_population
    population_json = File.read("storage/population.json")
    @population = JSON.parse(population_json)
    @population.sort_by! { |c| c['Year'] }
  end
end
