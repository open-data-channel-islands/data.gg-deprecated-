require 'nokogiri'
require 'open-uri'
require 'time'
class Api::V1::FlightsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
    end
  end

  def departures
    column_names = {
      0 => 'FlightNumber',
      1 => 'Time',
      2 => 'Dest',
      3 => 'Status'
    }

    url = 'http://www.guernsey-airport.gov.gg/webdepartures.html'
    @flights = table_to_flight_array(url, column_names)

    respond_to do |format|
      format.json { render json: @flights }
      format.xml { render xml: @flights }
      format.html { render html: @flights }
    end
  end

  def arrivals
    column_names = {
      0 => 'FlightNumber',
      1 => 'Time',
      2 => 'Source',
      3 => 'Status'
    }

    url = 'http://www.guernsey-airport.gov.gg/webarrivals.html'
    @flights = table_to_flight_array(url, column_names)

    respond_to do |format|
      format.json { render json: @flights }
      format.xml { render xml: @flights }
      format.html { render html: @flights }
    end

  end

  private

  def table_to_flight_array(url, column_names)
    table = url_to_table(url)

    flights = []
    active_date = DateTime.new

    table.each_with_index do |row, row_index|
      next if row_index == 1

      if row.count == 1 then
        active_date = Date.parse(row[0].split(':').last.strip)
      else
        flight_info_hash = { }

        flight_info_hash[column_names[0]] = row[0]

        time_parse_str = '%Y-%m-%d %H:%M'
        time_str = active_date.strftime('%Y-%m-%d') + ' ' + row[1]
        zone = 'London'
        time = ActiveSupport::TimeZone[zone].parse(time_str)

        flight_info_hash[column_names[1]] = time


        flight_info_hash[column_names[2]] = row[2]
        flight_info_hash[column_names[3]] = row[3]

        flights << flight_info_hash
      end
    end

    return flights
  end

  def url_to_table(url)
    doc = Nokogiri::HTML(open(url)) do |config|
      config.default_html.noent.nsclean
    end

    table = []
    current_row = []
    row_counter = 0
    doc.css('td').each_with_index do |cell|
      current_row << cell.text.strip

      row_increment = 1
      if cell.attr('colspan') then
        row_increment = cell.attr('colspan').to_i
      end
      row_counter += row_increment

      if row_counter >= 4 then
        table << current_row
        current_row = []
        row_counter = 0
      end
    end
    return table
  end
end
