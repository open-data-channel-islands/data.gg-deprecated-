require 'nokogiri'
require 'open-uri'

class Api::V1::SailingsController < ApplicationController

  def index
    respond_to do |format|
      format.html { render :index }
    end
  end

  def harbour

    @sailings = table_to_sailings_array()

    respond_to do |format|
      format.json { render json: @sailings }
      format.xml { render xml: @sailings }
      format.html { render html: @sailings }
    end
  end

  def herm_trident
    herm_trident_json = File.read("storage/#{ENV['place_code']}/herm_trident.json")
    @herm_tridents = JSON.parse(herm_trident_json)
    @herm_tridents.sort_by! { |c| c['Year'] }

    respond_to do |format|
      format.json { render json: @herm_tridents }
      format.xml { render xml: @herm_tridents }
      format.html { render html: @herm_tridents }
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
