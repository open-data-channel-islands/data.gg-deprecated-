class Charts::EmploymentController < ApplicationController
  def totals
    @title = 'Totals'
    totals_json = File.read("storage/#{ENV['place_code']}/employment/totals.json")
    totals = JSON.parse(totals_json)

    @labels = totals.map {|c| c['Quarter']}.uniq
    @labels.delete('Q4 2012') # missing data
    sort_order =['Q1','Q2','Q3','Q4']
    @labels = @labels.sort_by{ |x| [x[3..7].to_i, sort_order.index(x[0..2])] }
    @employed = []
    @unemployed = []
    @employers = []

    @labels.each do |period|
      total_for_period = totals.find { |t| t['Quarter'] == period }
      @employed << (total_for_period != nil ? total_for_period['Employed'] : 0)
      @unemployed << (total_for_period != nil ? total_for_period['Unemployed'] : 0)
      @employers << (total_for_period != nil ? total_for_period['Employers'] : 0)
    end


  end
end
