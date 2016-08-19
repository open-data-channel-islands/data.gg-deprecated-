class Charts::GovernmentSpendingController < ApplicationController
  def percent_treemap
    @title = 'Percent Treemap'
    percent_json = File.read("storage/#{ENV['place_code']}/government_spending/breakdown.json")
    percent = JSON.parse(percent_json)

    # Gov approved colouring!
    colours_json = File.read("storage/#{ENV['place_code']}/government_spending/colours.json")
    colours = JSON.parse(colours_json)

    @data = []

    year_2015 = percent.select{|p| p['Year'] == 2015}

    year_2015.each do |exp|

      exp_breakdown = exp['Breakdown']

      if !exp_breakdown.nil?
        @data << {
          name: exp['Expenditure'],
          id: exp['Expenditure'],
          color: colours[exp['Expenditure']]
        }
        exp_breakdown.each do |brk|
          @data << {
            name: brk['Expenditure'],
            value: brk['Percent'],
            parent: exp['Expenditure']
          }
        end
      else
        @data << {
          name: exp['Expenditure'],
          value: exp['Percent'],
          id: exp['Expenditure'],
          color: colours[exp['Expenditure']]
        }
      end
    end
  end

  def bubble_tree
    @title = 'Bubble Tree'

    percent_json = File.read("storage/#{ENV['place_code']}/government_spending/breakdown.json")
    percent = JSON.parse(percent_json)

    # Gov approved colouring!
    colours_json = File.read("storage/#{ENV['place_code']}/government_spending/colours.json")
    colours = JSON.parse(colours_json)

    data = []
    total = 0

    year_2015 = percent.select{|p| p['Year'] == 2015}
    year_2015.each do |exp|
      exp_breakdown = exp['Breakdown']
      children = []

      exp_obj = {
        label: exp['Expenditure'],
        amount: exp['Amount'],
        color: colours[exp['Expenditure']]
      }

      total += exp['Amount']

      if !exp_breakdown.nil?
        exp_breakdown.each do |brk|
          children << {
            label: brk['Expenditure'],
            amount: brk['Amount']
          }
          exp_obj['children'] = children
        end
      end

      data << exp_obj
    end

    root = {
      label: 'Total',
      amount: total,
      children: data,
      color: '#d9d9d9'
    }

    respond_to do |format|
      format.html
      format.json { render :json => root.to_json }
    end
  end

  def slider
    @title = 'Slider'
  end
end