require 'nokogiri'
require 'open-uri'
require 'time'
class SailingsParser

  def self.get_sailings
    table_to_sailings_array
  end

  private

  def self.table_to_sailings_array
    arrivals_departures = get_arrivals_departures_tables()

    if arrivals_departures == nil
      return []
    end

    return arrivals_departures
  end


  def self.get_arrivals_departures_tables
    url = 'http://www.harbours.gg/article/151766/Arrivals--Departures-scheduled-for-today--tomorrow'
    opened_url = open(url)
    doc = Nokogiri::HTML(opened_url) do |config|
      config.default_html.noent.nsclean
    end

    active_date = DateTime.now.beginning_of_day + 1.days

    arrival_column_names = {
      0 => 'Vessel',
      1 => 'Time',
      2 => 'Type',
      3 => 'Source',
      4 => 'Arrived'
    }

    departure_column_names = {
      0 => 'Vessel',
      1 => 'Time',
      2 => 'Type',
      3 => 'Destination',
      4 => 'Departed'
    }

    sailings = []


    set_back_start = 0
    set_back_end  = 0

    #<div class="tomorrowSep">Sailings scheduled for tomorrow</div>

    column_names = nil
    type = nil

    doc.css('div#content').each do |root|

      root.children.each_with_index do |content, i|

        sailings_info_hash = { }

        if content.attr('class') == 'headerRowContainer'
        # Arrivals show first, could use class but already have to do this
        # to figure out the day anyway.
        if type.nil?
          #p 'Arrival Found'
          type = 'Arrival'
          column_names = arrival_column_names
        else
          #p 'Departure Found'
          type = 'Departure'
          column_names = departure_column_names
        end

        set_back_start = i
        set_back_end = i
      end


      set_back_end = i



      # Found next day marker, set previous
      if content.attr('class') == 'tomorrowSep'# || type == 'Departure'

      #p "i is #{i}"
      #p "start is #{set_back_start}"
      #p "end is #{set_back_end}"
      #p sailings.count

        sailings[set_back_start..set_back_end].each do |set_back|
          #p set_back
          #p set_back.length

          next if set_back.length == 0
          set_back[column_names[1]] = set_back[column_names[1]] - 1.days
        end

        set_back_start = i
      end

      if !content.attr('class').nil? && content.attr('class').include?('recordContainer')

        #if record.attr('class').include? 'arrival'
            #type = 'Arrival'
            #column_names = arrival_column_names
        #  end

         # if record.attr('class').include? 'departure'
            #type = 'Departure'
            #column_names = departure_column_names
          #end

          content.css('div.recordRow').each do |record_data|
            vessel_text = record_data.children[0].text
            location_text = record_data.children[1].text
            time_text = record_data.children[2].text
            reached_text = record_data.children[3].text


            sailings_info_hash = { }
            sailings_info_hash[column_names[0]] = vessel_text

            time_parse_str = '%Y-%m-%d %H:%M'
            time_str = active_date.strftime('%Y-%m-%d') + ' ' + time_text
            zone = 'London'
            time = ActiveSupport::TimeZone[zone].parse(time_str, DateTime.now)


            sailings_info_hash[column_names[1]] = time

            sailings_info_hash[column_names[2]] = type

            sailings_info_hash[column_names[3]] = location_text
            sailings_info_hash[column_names[4]] = reached_text
          end
        end

        sailings << sailings_info_hash


      end
    end

    return sailings.delete_if {|k,v| k.length == 0 }
  end
end