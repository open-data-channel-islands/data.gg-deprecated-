class Api::V10::PopulationController < ApplicationController

  def population
    population_json = File.read("storage/population/population.json")
    @population = JSON.parse(population_json)
    @population.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @population }
      # We use a template builder for this one as the data column names have numbers in them
      # and XML sucks.
      format.xml { @population }
      format.html { render :population, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def age
    json_data = File.read("storage/population/age.json")
    @age = JSON.parse(json_data)

    respond_to do |format|
      format.json { render json: @age }
      # We use a template builder for this one as the data column names have numbers in them
      # and XML sucks.
      format.xml { @age }
      format.html { render :age, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def age_female
    json_data = File.read("storage/population/age_female.json")
    @age_female = JSON.parse(json_data)

    respond_to do |format|
      format.json { render json: @age_female }
      # We use a template builder for this one as the data column names have numbers in them
      # and XML sucks.
      format.xml { @age_female }
      format.html { render :age_female, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def age_male
    json_data = File.read("storage/population/age_male.json")
    @age_male = JSON.parse(json_data)

    respond_to do |format|
      format.json { render json: @age_male }
      # We use a template builder for this one as the data column names have numbers in them
      # and XML sucks.
      format.xml { @age_male }
      format.html { render :age_male, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def birthplace
    json_data = File.read("storage/population/birthplace.json")
    @birthplace = JSON.parse(json_data)

    respond_to do |format|
      format.json { render json: @birthplace }
      format.xml { render xml: @birthplace }
      format.html { render :birthplace, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def changes
    json_data = File.read("storage/population/changes.json")
    @changes = JSON.parse(json_data)

    respond_to do |format|
      format.json { render json: @changes }
      format.xml { render xml: @changes }
      format.html { render :changes, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def district
    json_data = File.read("storage/population/district.json")
    @district = JSON.parse(json_data)

    respond_to do |format|
      format.json { render json: @district }
      format.xml { render xml: @district }
      format.html { render :district, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def parish
    json_data = File.read("storage/population/parish.json")
    @parish = JSON.parse(json_data)

    respond_to do |format|
      format.json { render json: @parish }
      format.xml { render xml: @parish }
      format.html { render :parish, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

end
