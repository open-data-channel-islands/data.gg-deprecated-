require 'json'
class Api::V1::EducationController < ApplicationController
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
      format.html { render html: @post16results }
    end
  end
end
