class Api::V10::FinanceController < ApplicationController
  def banking
    @title = 'Banking'
    banking_json = File.read("storage/#{ENV['place_code']}/finance/banking.json")
    @banking = JSON.parse(banking_json)

    respond_to do |format|
      format.json { render json: @banking }
      format.xml { render xml: @banking }
      format.html { render :banking, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end
end
