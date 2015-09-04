class Charts::FinanceController < ApplicationController

  def licences
    @title = 'Licences'
    banking_json = File.read("storage/#{ENV['place_code']}/finance/banking.json")
    banking = JSON.parse(banking_json)

    @licences = []
    @labels = []

    banking.sort_by{ |p| p["Quarter"] }.each do |val|
      @labels << val["Quarter"].to_s# + ' ' + val["Year"].to_s
      @licences << val['BankingLicences']
    end
  end

  def deposits
    @title = 'Deposits'
    banking_json = File.read("storage/#{ENV['place_code']}/finance/banking.json")
    banking = JSON.parse(banking_json)

    @deposits = []
    @labels = []

    banking.sort_by{ |p| p["Quarter"] }.each do |val|
      @labels << val["Quarter"].to_s #+ ' ' + val["Year"].to_s
      @deposits << val['TotalDeposits']
    end
  end
end
