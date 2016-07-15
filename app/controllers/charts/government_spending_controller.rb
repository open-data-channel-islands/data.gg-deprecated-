class Charts::GovernmentSpendingController < ApplicationController
  def percent_treemap
    @title = 'Percent Treemap'
    percent_json = File.read("storage/#{ENV['place_code']}/government_spending/percentage.json")
    percent = JSON.parse(percent_json)

    colours = {
      'Health and community services' => 'rgb(75, 172, 198)',
      'Pensions' => 'rgb(102, 204, 255)',
      'Education' => 'rgb(228, 223, 236)',
      'Social welfare benefits' => 'rgb(146, 208, 80)',
      'Order and Safety' => 'rgb(218, 238, 243)',
      'Government and administration' => 'rgb(255, 102, 0)',
      'Transfer to capital reserve' => 'rgb(255,255,0)',
      'Land management infrastructure and transport' => 'rgb(255,0,0)',
      'Economic development and tourism' => 'rgb(204, 51, 153)',
      'Arts sport and culture' => 'rgb(204, 153, 255)'
    }

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
end


                #name: 'A',
                #value: 6,
                #colorValue: 1
