require 'json'
class Api::V10::EducationController < ApplicationController

  def index
    respond_to do |format|
      format.html { render :index }
    end
  end

  def post16results
    post16results_json = File.read("storage/post16results.json")

    @post16results = JSON.parse(post16results_json)
    @post16results.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @post16results }
      format.xml { render xml: @post16results }
      format.html { render :post16results, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def gcse_overall
    gcse_overall_json = File.read("storage/gcse_overall.json")

    @gcse_overall = JSON.parse(gcse_overall_json)
    @gcse_overall.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @gcse_overall }
      format.xml { render xml: @gcse_overall }
      format.html { render :gcse_overall, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def gcse_school
    gcse_school_json = File.read("storage/gcse_school.json")

    @gcse_school = JSON.parse(gcse_school_json)
    @gcse_school.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @gcse_school }
      format.xml { render xml: @gcse_school }
      format.html { render :gcse_school, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

end
