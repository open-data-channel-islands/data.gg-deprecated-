class Api::V1::EarningsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
    end
  end
end
