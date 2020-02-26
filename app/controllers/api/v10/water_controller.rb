class  Api::V10::WaterController  <  ApplicationController
    def  domestic_consumption
        @title  =  'Domestic  Consumption'
        domestic_consumption_json  =  File.read("storage/#{ENV['place_code']}/water/domestic_consumption.json")
        @domestic_consumption  =  JSON.parse(domestic_consumption_json)

        respond_to  do  |format|
            format.json  {  render  json:  @domestic_consumption  }
            format.xml  {  render  xml:  @domestic_consumption  }
            format.html  {  render  :domestic_consumption,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end
end
