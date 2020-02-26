class  Api::V10::WeatherController  <  ApplicationController
    def  annual
        @title  =  'Annual'
        annual_json  =  File.read("storage/#{ENV['place_code']}/weather/metoffice_annual_report.json")
        @annual  =  JSON.parse(annual_json)

        respond_to  do  |format|
            format.json  {  render  json:  @annual  }
            format.xml  {  render  xml:  @annual  }
            format.html  {  render  :annual,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  monthly
        @title  =  'Monthly'
        monthly_json  =  File.read("storage/#{ENV['place_code']}/weather/metoffice_monthly_report.json")
        @monthly  =  JSON.parse(monthly_json)

        respond_to  do  |format|
            format.json  {  render  json:  @monthly  }
            format.xml  {  render  xml:  @monthly  }
            format.html  {  render  :monthly,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  frost_days
        @title  =  'Frost  Days'
        frost_days_json  =  File.read("storage/#{ENV['place_code']}/weather/frost_days.json")
        @frost_days  =  JSON.parse(frost_days_json)

        respond_to  do  |format|
            format.json  {  render  json:  @frost_days  }
            format.xml  {  render  xml:  @frost_days  }
            format.html  {  render  :frost_days,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end
end
