require 'chart_colours'
class Charts::HousingController < ApplicationController

  def mean_average
    @title = 'Mean Average'
    houses_json = File.read("storage/houses/local_prices.json")
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
    houses_json = File.read("storage/houses/local_prices.json")
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

  def local_price_transactions

    houses_json = File.read("storage/houses/local_prices.json")
    house_prices = JSON.parse(houses_json)

    @labels = []
    transactions = [ ]
    means = [ ]
    house_prices.select {|p| p['Year'] >= 1999}.sort_by{|p| [p["Year"], p["Quarter"]]}.each do |val|
      @labels << val["Quarter"].to_s + ' ' + val["Year"].to_s
      transactions << val['Transactions']
      means << val['Mean']
    end

    @data = [ ]

    transaction_fill ="rgba(#{ChartColours::COLOURS[0].join(',')})"
    transaction_transparent = Array.new(ChartColours::COLOURS[0])
    transaction_transparent[3] = 0
    transaction_fill_transparent ="rgba(#{transaction_transparent.join(',')})"
    transaction_stroke = "rgba(#{ChartColours::darken_color(ChartColours::COLOURS[0]).join(',')})"
    @data << {
      :label => 'Transactions',
      :fillColor => transaction_fill_transparent,
      :strokeColor => transaction_stroke,
      :pointColor => transaction_fill,
      :pointStrokeColor => transaction_stroke,
      :data => transactions }

    mean_fill ="rgba(#{ChartColours::COLOURS[1].join(',')})"
    mean_transparent = Array.new(ChartColours::COLOURS[1])
    mean_transparent[3] = 0
    mean_fill_transparent ="rgba(#{mean_transparent.join(',')})"
    mean_stroke = "rgba(#{ChartColours::darken_color(ChartColours::COLOURS[1]).join(',')})"
    @data << {
      :label => 'Mean',
      :fillColor => mean_fill_transparent,
      :strokeColor => mean_stroke,
      :pointColor => mean_fill,
      :pointStrokeColor => mean_stroke,
      :data => means }
  end

end