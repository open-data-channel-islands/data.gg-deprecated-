require 'nokogiri'
require 'open-uri'

class FlightsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
    end
  end

  def download_departures
    column_names = {
      0 => 'FlightNumber',
      1 => 'Time',
      2 => 'Dest',
      3 => 'Status'
    }

    url = 'http://www.guernsey-airport.gov.gg/webdepartures.html'
    table = url_to_table(url)
    @flights = table_to_flight_array(table, column_names)

    respond_to do |format|
      format.json { render json: @flights }
      format.xml { render xml: @flights }
      format.html { render html: @flights } # TODO: Needs actual view
    end
  end

  def download_arrivals
    column_names = {
      0 => 'FlightNumber',
      1 => 'Time',
      2 => 'Source',
      3 => 'Status'
    }

    url = 'http://www.guernsey-airport.gov.gg/webarrivals.html'
    table = url_to_table(url)
    @flights = table_to_flight_array(table, column_names)

    respond_to do |format|
      format.json { render json: @flights }
      format.xml { render xml: @flights }
      format.html { render html: @flights } # TODO: Needs actual view
    end

  end

  private

  def table_to_flight_array(table, column_names)

    today_status = ""
    today_date = Date.new
    today_flights = []
    tomorrow_status = ""
    tomorrow_date = Date.new
    tomorrow_flights = []
    #flights = []

    table.each_with_index do |row, row_index|
      if row.count == 1 then
        if today_status.empty? then
          today_status = row[0]
          today_status_date = today_status.split(':').last.strip
          today_date = Date.parse(today_status_date)
        else
          tomorrow_status = row[0]
          tomorrow_status_date = tomorrow_status.split(':').last.strip
          tomorrow_date = Date.parse(tomorrow_status_date)
        end
      else
        next if row_index == 1

        flight_info_hash = { }
        row.each_with_index do |cell, cell_index|
          flight_info_hash[column_names[cell_index]] = cell
        end

        if tomorrow_status.empty? then
          today_flights << flight_info_hash
        else
          tomorrow_flights << flight_info_hash
        end
      end
    end

    return today_flights
  end

  def url_to_table(url)
    doc = Nokogiri::HTML(open(url)) do |config|
      config.default_html.noent.nsclean
    end

    table = []
    current_row = []
    row_counter = 0
    doc.css('td').each_with_index do |cell|
      if row_counter >= 4 then
        table << current_row
        current_row = []
        row_counter = 0
      end

      current_row << cell.text.strip

      row_increment = 1
      if cell.attr('colspan') then
        row_increment = cell.attr('colspan').to_i
      end
      row_counter += row_increment
    end
    return table
  end
end
