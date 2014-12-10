class Charts::HousingController < ApplicationController
  
  def mean_average
    
    houses_json = File.read("storage/house_prices.json")
    house_prices = JSON.parse(houses_json)

    colours = [["rgba(235,140,45,0.5)", "rgba(219,111,2,0.5)"],
               ["rgba(51,184,224,0.5)", "rgba(9,162,222,0.5)"],
               ["rgba(51,222,111,0.5)", "rgba(2,196,70,0.5)"]]
               
    mean_average_prices = []
    @labels = []
               
    house_prices.sort_by{|p| [p["Year"], p["Quarter"]]}.each do |val|

      @labels << val["Quarter"].to_s + ' ' + val["Year"].to_s
      mean_average_prices << val["MeanAverageToppedAndTailed"]
                    
    end
    
    @data = [{ :fillColor => colours[0][0], :strokeColor => colours[0][1],
      :pointColor => "rgba(100,100,100,1)", :pointStrokeColor => "#FFFFFF",
      :data => mean_average_prices }]
    
    
    
  end
  
  def transactions
    houses_json = File.read("storage/house_prices.json")
    house_prices = JSON.parse(houses_json)

    colours = [["rgba(235,140,45,0.5)", "rgba(219,111,2,0.5)"],
               ["rgba(51,184,224,0.5)", "rgba(9,162,222,0.5)"],
               ["rgba(51,222,111,0.5)", "rgba(2,196,70,0.5)"]]
           
    transactions = []
    @labels = []
           
    house_prices.sort_by{|p| [p["Year"], p["Quarter"]]}.each do |val|

      if val["NoOfTransactions"]
        @labels << val["Quarter"].to_s + ' ' + val["Year"].to_s
        transactions << val["NoOfTransactions"]
      end
      
                
    end

    @data = [{ :fillColor => colours[0][0], :strokeColor => colours[0][1],
      :pointColor => "rgba(100,100,100,1)", :pointStrokeColor => "#FFFFFF",
      :data => transactions }]
  end
  
end