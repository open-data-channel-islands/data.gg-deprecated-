class Api::V1::PopulationController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
    end
  end

  def population
    population_json = File.read("storage/population.json")
    @population = JSON.parse(population_json)
    @population.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @population }
      format.xml { render xml: @population }
      format.html { render html: @population }
    end
  end
end
