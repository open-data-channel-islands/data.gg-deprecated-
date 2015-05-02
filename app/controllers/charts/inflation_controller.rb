require 'chart_colours'
require 'bigdecimal'
require 'bigdecimal/util'

class Charts::InflationController < ApplicationController
  def changes
    @title = 'Changes'
    changes_json = File.read("storage/inflation/changes.json")
    changes = JSON.parse(changes_json)
    changes.select! { |c| Date.strptime(c['Quarter'], "%d/%m/%Y") >= Date.new(1999,3,31) }


    rpi_counter = 100
    rpix_counter = 100

    @labels = []
    @rpis = []
    @rpixs = []

    changes.each do |c|
      rpi_fract = (rpi_counter / 100) * c['RPI Quarterly Change']
      rpi = rpi_fract + rpi_counter

      rpix_fract  = (rpix_counter / 100) * c['RPIX Quarterly Change']
      rpix = rpix_counter + rpix_fract

      @labels << c['Quarter']
      @rpis << rpi
      @rpixs << rpix

      rpi_counter = rpi
      rpix_counter = rpix
    end

    respond_to do |format|
      format.html
    end
  end

  def rpi_group_changes
    @title = 'RPI Group Changes'
    changes_json = File.read("storage/inflation/rpi_group_changes.json")
    changes = JSON.parse(changes_json)

    @labels = changes.map {|c| c['Quarter']}.uniq!
    @labels.delete('Q4 2004') # delete to match the states sheet
    sort_order =['Q1','Q2','Q3','Q4']
    @labels = @labels.sort_by{ |x| [x[3..7].to_i, sort_order.index(x[0..2])] }
    @results = []

    changes.group_by{ |p| p['Type'] }.each do |type,val|
      result = []
      rpi_counter = 100

      @labels.each do |lbl|
       value_for_lbl = val.find { |v| v['Quarter'] == lbl }
       change = (value_for_lbl != nil ? value_for_lbl['Quarterly Change'] : 0)

       fract = (rpi_counter / 100) * change
       rpi = fract + rpi_counter

       result << rpi
       rpi_counter = rpi
      end

      @results << { name: type, data: result }

    end
  end
end
