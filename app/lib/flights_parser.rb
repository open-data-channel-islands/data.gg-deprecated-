require  'nokogiri'
require  'open-uri'
require  'time'
class  FlightsParser

    def  self.get_arrivals
        column_names  =  {
            0  =>  'FlightNumber',
            1  =>  'Time',
            2  =>  'Source',
            3  =>  'Status'
        }
        url  =  'https://www.airport.gg/arrivals-departures'
        name  =  'arrivals'
        @flights  =  FlightsParser::new_table_to_flight_array(url,  column_names,  name)
    end

    def  self.get_departures
        column_names  =  {
            0  =>  'FlightNumber',
            1  =>  'Time',
            2  =>  'Dest',
            3  =>  'Status'
        }
        url  =  'https://www.airport.gg/arrivals-departures'
        name  =  'departures'
        @flights  =  FlightsParser::new_table_to_flight_array(url,  column_names,  name)
    end

    private

        def  self.new_url_to_table(url,name)
        doc  =  Nokogiri::HTML(open(url))  do  |config|
            config.default_html.noent.nsclean
        end

        table  =  []
        current_row  =  []
        row_counter  =  0

        html_div  =  doc.xpath("//div[@data-tab='#{name}']")
        html_div.css('td').each_with_index  do  |cell|
            current_row  <<  cell.text.strip

            row_increment  =  1
            if  cell.attr('colspan')  then
                row_increment  =  cell.attr('colspan').to_i
            end
            row_counter  +=  row_increment

            if  row_counter  >=  6  then
                table  <<  current_row
                current_row  =  []
                row_counter  =  0
            end
        end
        return  table
    end

    def  self.new_table_to_flight_array(url,  column_names,name)
        table  =  new_url_to_table(url,name)
        zone  =  'London'
        flights  =  []
        table.each_with_index  do  |row,  row_index|
            next  if  row.count  ==  1
            flight_info_hash  =  {  }
            flight_info_hash[column_names[0]]  =  row[4]
            date_time_combined  =  "#{row[2][0..9]}  #{row[1]}"
            flight_info_hash[column_names[1]]  =  ActiveSupport::TimeZone[zone].parse(date_time_combined,  DateTime.now)
            flight_info_hash[column_names[2]]  =  row[3]
            flight_info_hash[column_names[3]]  =  row[5]
            flights  <<  flight_info_hash
        end

        return  flights
    end
end