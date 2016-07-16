class Charts::GovernmentSpendingController < ApplicationController
  def percent_treemap
    @title = 'Percent Treemap'
    percent_json = File.read("storage/#{ENV['place_code']}/government_spending/percentage.json")
    percent = JSON.parse(percent_json)

    # Gov approved colouring!
    colours_json = File.read("storage/#{ENV['place_code']}/government_spending/colours.json")
    colours = JSON.parse(colours_json)

    p colours

    @data = []

    year_2015 = percent.find{|p| p['Year'] == 2015}

    year_2015.each do |key, value|
      next if key == 'Year'

      @data << {
        name: key,
        value: value,
        color: colours[key]
      }
    end
  end

  def slider
    @title = 'Slider'
  end
end