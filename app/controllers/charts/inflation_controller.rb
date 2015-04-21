require 'chart_colours'
require 'bigdecimal'
require 'bigdecimal/util'

class Charts::InflationController < ApplicationController
  def changes
    changes_json = File.read("storage/inflation/changes.json")
    changes = JSON.parse(changes_json)
    changes.select! { |c| Date.strptime(c['Quarter'], "%d/%m/%Y") >= Date.new(1999,3,31) }

    @changes = []
    rpi_counter = 100
    rpix_counter = 100

    changes.each do |c|
      rpi_fract = (rpi_counter / 100) * c['RPI Quarterly Change']
      rpi = rpi_fract + rpi_counter

      rpix_fract  = (rpix_counter / 100) * c['RPIX Quarterly Change']
      rpix = rpix_counter + rpix_fract

      @changes << { 'Quarter': c['Quarter'], 'RPI': rpi, 'RPIX': rpix }
      rpi_counter = rpi
      rpix_counter = rpix
    end

    respond_to do |format|
      format.html { render :changes }
    end
  end

  def rpi_group_changes
    changes_json = File.read("storage/inflation/rpi_group_changes.json")
    changes = JSON.parse(changes_json)

    @types = changes.map {|c| c['Type']}.uniq!
    @periods = changes.map {|c| c['Quarter']}.uniq!
    @periods.delete('Q4 2004') # delete to match the states sheet
    sort_order =['Q1','Q2','Q3','Q4']
    @periods = @periods.sort_by{ |x| [x[3..7].to_i, sort_order.index(x[0..2])] }
    @type_colour_keys = { }
    @results = []

    colour_keys = { }
    @types.each_with_index do |t, i|
      colour_keys[t] = ChartColours::COLOURS[i]
    end

    changes.group_by{ |p| p['Type'] }.each do |type,val|
      result = []
      rpi_counter = 100

      @periods.each do |lbl|
       value_for_lbl = val.find { |v| v['Quarter'] == lbl }
       change = (value_for_lbl != nil ? value_for_lbl['Quarterly Change'] : 0)

       fract = (rpi_counter / 100) * change
       rpi = fract + rpi_counter

       result << rpi
       rpi_counter = rpi
      end

      fill = "rgba(#{colour_keys[type].join(',')})"
      stroke ="rgba(#{ChartColours::darken_color(colour_keys[type]).join(',')})"

      @type_colour_keys[type] = [fill,stroke]

      transparent = []
      transparent << colour_keys[type][0]
      transparent << colour_keys[type][1]
      transparent << colour_keys[type][2]
      transparent << "0"
      transparent_fill = "rgba(#{transparent.join(',')})"

      hash = {
        :label => type,
        :fillColor => transparent_fill,
        :strokeColor => stroke,
        :pointColor => fill,
        :pointStrokeColor => stroke,
        :data => result
      }

      @results << hash
    end

  end
end
