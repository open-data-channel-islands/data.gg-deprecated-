class Charts::PopulationController < ApplicationController

  def male_vs_female
    @title = 'Male vs Female'
    population_json = File.read("storage/#{ENV['place_code']}/population/population.json")
    population = JSON.parse(population_json)

    @male = []
    @female = []
    @min_label = population.min{ |val| val["Year"].to_i }['Year'].to_i

    population.sort_by{|p| p['Year'].to_i }.each do |val|
      if val['Sex'] == 'Male'
        @male << sum_population_row(val)
      else
        @female << sum_population_row(val)
      end
    end

    respond_to do |format|
      format.html
    end
  end

  def parish
    @title = 'Parish'
    @svg = File.read("storage/#{ENV['place_code']}/parish.svg")
    #@svg = File.read("storage/je/parish.svg")
  end

  private

  def sum_population_row(population)
    number_cols = %w(0-4 5-9 10-14 15-19 20-24 25-29 30-34
      35-39 40-44 45-49 50-54 55-59 60-64 65-69 70-74
      75-79 80-84 85-89 90-94 95+)
    sum = 0
    number_cols.each do |c|
      sum += population[c] if !population[c].nil?
    end

    return sum
  end

end