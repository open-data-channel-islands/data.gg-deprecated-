require 'nokogiri'
require 'open-uri'

class Api::V10::SailingsController < ApplicationController

  def harbour
    @title = 'Harbour'
    @sailings = table_to_sailings_array()
    respond_to do |format|
      format.json { render json: @sailings }
      format.xml { render xml: @sailings }
      format.html { render :harbour, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def condor_punctuality
    @title = 'Condor Punctuality'
    punctuality_json = File.read("storage/#{ENV['place_code']}/sailings/condor_punctuality.json")
    @punctuality = JSON.parse(punctuality_json)

    respond_to do |format|
      format.json { render json: @punctuality }
      format.xml { render xml: @punctuality }
      format.html { render :condor_punctuality, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  def cruises
    @title = 'Cruises'
    cruises_json = File.read("storage/#{ENV['place_code']}/sailings/cruises.json")
    @cruises = JSON.parse(cruises_json)

    respond_to do |format|
      format.json { render json: @cruises }
      format.xml { render xml: @cruises }
      format.html { render :cruises, layout: ((params[:layout].nil? || params[:layout] == 'true') ? true : false) }
    end
  end

  private

  def table_to_sailings_array()
    arrivals, departures = get_arrivals_departures_tables()

    if arrivals == nil || departures == nil
      return []
    end

    return parse_table(arrivals, "Arrival", "Source", "Arrived") +
    parse_table(departures, "Departure", "Destination", "Departed")
  end

  def parse_table(table, type, place_name, status_name)
    column_names = {
      0 => 'Vessel',
      1 => 'Time',
      2 => 'Type',
      3 => place_name,
      4 => status_name
    }

    # If the table doesn't contain a one cell row then the
    # table is for tomorrow.
    active_date = DateTime.now.beginning_of_day + 1.days
    table.each_with_index do |row, row_index|
      next if row_index == 0
      if row.count == 1 then
        active_date = DateTime.now.beginning_of_day
      end
    end

    sailings = []

    table.each_with_index do |row, row_index|
      next if row_index == 0

      if row.count == 1 then
        active_date = active_date + 1.days
      else
        sailings_info_hash = { }
        sailings_info_hash[column_names[0]] = row[0]

        time_parse_str = '%Y-%m-%d %H:%M'
        time_str = active_date.strftime('%Y-%m-%d') + ' ' + row[2]
        zone = 'London'
        time = ActiveSupport::TimeZone[zone].parse(time_str, DateTime.now)



        sailings_info_hash[column_names[1]] = time

        sailings_info_hash[column_names[2]] = type

        sailings_info_hash[column_names[3]] = row[1]
        sailings_info_hash[column_names[4]] = row[3]

        sailings << sailings_info_hash
      end
    end

    return sailings
  end

  def get_arrivals_departures_tables()
    url = 'http://www.guernseyharbours.gov.gg/article/100192/Arrivals--Departures'
    opened_url = open(url)
    doc = Nokogiri::HTML(opened_url) do |config|
      config.default_html.noent.nsclean
    end

    tables = []

    doc.css('.FeedTable').each do |feedTable|
      table = []
      current_row = []
      row_counter = 0

      feedTable.css('td').each do |cell|

        # strip wasn't working
        # http://stackoverflow.com/questions/3913900/ruby-1-9-strip-not-removing-whitespace
        current_row << cell.text.gsub("\302\240", ' ').strip

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
      tables << table
    end

    arrivals =[]
    departures =[]

    if tables[0] != nil
      if tables[0][0][3] == "Departed"
        departures = tables[0]
      else
        arrivals = tables[0]
      end
    end

    if tables[1] != nil
      if tables[1][0][3] == "Departed"
        departures = tables[1]
      else
        arrivals = tables[1]
      end
    end

    return arrivals, departures
  end

end
