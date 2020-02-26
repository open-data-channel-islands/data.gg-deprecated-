require  'nokogiri'
require  'open-uri'

class  Api::V10::SailingsController  <  ApplicationController

    def  harbour
        @title  =  'Harbour'
        @sailings  =  SailingsParser::get_sailings
        respond_to  do  |format|
            format.json  {  render  json:  @sailings  }
            format.xml  {  render  xml:  @sailings  }
            format.html  {  render  :harbour,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  condor_punctuality
        @title  =  'Condor  Punctuality'
        punctuality_json  =  File.read("storage/#{ENV['place_code']}/sailings/condor_punctuality.json")
        @punctuality  =  JSON.parse(punctuality_json)

        respond_to  do  |format|
            format.json  {  render  json:  @punctuality  }
            format.xml  {  render  xml:  @punctuality  }
            format.html  {  render  :condor_punctuality,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  cruises
        @title  =  'Cruises'
        cruises_json  =  File.read("storage/#{ENV['place_code']}/sailings/cruises.json")
        @cruises  =  JSON.parse(cruises_json)

        respond_to  do  |format|
            format.json  {  render  json:  @cruises  }
            format.xml  {  render  xml:  @cruises  }
            format.html  {  render  :cruises,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end
end
