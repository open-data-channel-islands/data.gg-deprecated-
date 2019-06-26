require 'chart_colours'
class Charts::HousingController < ApplicationController

  def mean_average
    @title = 'Mean Average'
    houses_json = File.read("storage/#{ENV['place_code']}/houses/local_prices.json")
    house_prices = JSON.parse(houses_json)

    @mean_averages = []
    @labels = []

    house_prices.sort_by{|p| [p["Year"], p["Quarter"]]}.each do |val|
      @labels << val["Quarter"].to_s + ' ' + val["Year"].to_s
      @mean_averages << val['Mean']
    end
  end

  def transactions
    @title = 'Transactions'
    houses_json = File.read("storage/#{ENV['place_code']}/houses/local_prices.json")
    house_prices = JSON.parse(houses_json)

    @transactions = []
    @labels = []

    house_prices.sort_by{|p| [p["Year"], p["Quarter"]]}.each do |val|
      if val["Transactions"]
        @labels << val["Quarter"].to_s + ' ' + val["Year"].to_s
        @transactions << val["Transactions"]
      end
    end
  end

  def bedrooms
    @title = 'Bedrooms (2018)'

    bedrooms_json = File.read("storage/#{ENV['place_code']}/houses/bedrooms.json")
    bedrooms = JSON.parse(bedrooms_json)

    @local = []
    @open = []
    @labels = ['1','2','3','4','Over 4','Unknown']

    bedrooms.select { |b| b['Year'] == 2018 }.each do |val|
      if val['Market'] == 'Local'
        @local = @labels.collect { |lbl| val[lbl] }
      else
        @open = @labels.collect { |lbl| val[lbl] }
      end
    end

    respond_to do |format|
      format.html
    end
  end

  def types
    @title = 'Types'

    types_json = File.read("storage/#{ENV['place_code']}/houses/types.json")
    types = JSON.parse(types_json)

    @local = []
    @open = []
    types.select{ |u| u['Year'] == 2018 }.each do |val|
      @local << [ val['Type'], val['Local Market'] ]
      @open << [ val['Type'], val['Open Market'] ]
    end

    respond_to do |format|
       format.html
    end
  end

  def units
    @title ='Units'

    units_json = File.read("storage/#{ENV['place_code']}/houses/units.json")
    units = JSON.parse(units_json)

    @local = []
    @open = []
    @labels = units.collect { |val| val["Year"].to_i }.uniq

    units.sort_by{|p| p['Year'].to_i }.each do |val|
      @local << val['Local Market']
      @open << val['Open Market']
    end

    respond_to do |format|
      format.html
    end
  end

end