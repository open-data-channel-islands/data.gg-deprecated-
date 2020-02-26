require  'nokogiri'
require  'open-uri'
require  'time'
class  Api::V10::FlightsController  <  ApplicationController
    require_dependency  'flights_parser'

    def  departures
        @title  =  'Departures'

        if  Rails.cache.exist?  'departures'
            @flights  =  Rails.cache.fetch('departures')
        else
            @flights  =  FlightsParser::get_departures
            Rails.cache.write('departures',  @flights,  expires_in:  30.seconds)
        end

        respond_to  do  |format|
            format.json  {  render  json:  @flights  }
            format.xml  {  render  xml:  @flights  }
            format.html  {  render  :departures,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  arrivals
        @title  =  'Arrivals'

        if  Rails.cache.exist?  'arrivals'
            @flights  =  Rails.cache.fetch('arrivals')
        else
            @flights  =  FlightsParser::get_arrivals
            Rails.cache.write('arrivals',  @flights,  expires_in:  30.seconds)
        end


        respond_to  do  |format|
            format.json  {  render  json:  @flights  }
            format.xml  {  render  xml:  @flights  }
            format.html  {  render  :arrivals,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end

    end

end
