require 'nokogiri'
require 'open-uri'
require 'time'
class Api::V1::FlightsController < ApplicationController

  def departures
    column_names = {
      0 => 'FlightNumber',
      1 => 'Time',
      2 => 'Dest',
      3 => 'Status'
    }

    url = 'https://www.airport.gg/arrivals-departures'
    name = 'departures'
    @flights = new_table_to_flight_array(url, column_names, name)

    respond_to do |format|
      format.json { render json: @flights }
      format.xml { render xml: @flights }
      format.html { render :departures }
    end
  end

  def arrivals
    column_names = {
      0 => 'FlightNumber',
      1 => 'Time',
      2 => 'Source',
      3 => 'Status'
    }

    url = 'https://www.airport.gg/arrivals-departures'
    name = 'arrivals'
    @flights = new_table_to_flight_array(url, column_names, name)

    respond_to do |format|
      format.json { render json: @flights }
      format.xml { render xml: @flights }
      format.html { render :arrivals }
    end

  end

  private

  def new_url_to_table(url,name)
    doc = Nokogiri::HTML(open(url)) do |config|
      config.default_html.noent.nsclean
    end

    table = []
    current_row = []
    row_counter = 0

    html_div = doc.xpath("//div[@data-tab='#{name}']")
    html_div.css('td').each_with_index do |cell|
      current_row << cell.text.strip

      row_increment = 1
      if cell.attr('colspan') then
        row_increment = cell.attr('colspan').to_i
      end
      row_counter += row_increment

      if row_counter >= 5 then
        table << current_row
        current_row = []
        row_counter = 0
      end
    end
    return table
  end

  def new_table_to_flight_array(url, column_names,name)
    table = new_url_to_table(url,name)

    # New website has times any no indication of date so we need to
    # perform some magic here.
    times = []
    table.each_with_index do |row, row_index|
      active_date = DateTime.now
      time_str = active_date.strftime('%Y-%m-%d') + ' ' + row[1]
      zone = 'London'
      time = ActiveSupport::TimeZone[zone].parse(time_str, DateTime.now)
      times << time
    end

    if times[0].hour < 12
      now = DateTime.now
      if now.hour > 12
        # All tomorrow
        times.each_with_index do |time, index|
          times[index] = time + 24.hours
        end
      end
    else
      # All today until next AM
      found_redeye=false
      times.each_with_index do |time, index|
        if time.hour < 12 && !found_redeye
          found_redeye=true
        end
        if found_redeye
          times[index] = time + 24.hours
        end
      end
    end

    flights = []
    table.each_with_index do |row, row_index|
      flight_info_hash = { }
      flight_info_hash[column_names[0]] = row[3]
      flight_info_hash[column_names[1]] = times[row_index]
      flight_info_hash[column_names[2]] = row[2]
      flight_info_hash[column_names[3]] = row[4]
      flights << flight_info_hash
    end

    return flights
  end
end
