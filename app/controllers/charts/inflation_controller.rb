class Charts::InflationController < ApplicationController
  def changes
     changes_json = File.read("storage/inflation/changes.json")
    changes = JSON.parse(changes_json)
    changes.select! { |c| Date.strptime(c['Quarter'], "%d/%m/%Y") >= Date.new(1999,3,31) }

    @changes = []
    rpi_counter = 100
    rpix_counter = 100
    changes.each do |c|
      rpi = c['RPI Quarterly Change'] + rpi_counter
      rpix = c['RPIX Quarterly Change'] + rpix_counter

      p rpi
      p rpix
      @changes << { 'Quarter': c['Quarter'], 'RPI': rpi, 'RPIX': rpix }
      rpi_counter = rpi
      rpix_counter = rpix
    end

    p @changes

    respond_to do |format|
      format.html { render :changes }
    end
  end
end
