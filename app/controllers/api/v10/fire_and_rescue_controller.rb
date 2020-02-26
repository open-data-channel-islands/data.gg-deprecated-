class  Api::V10::FireAndRescueController  <  ApplicationController
    def  attendances
        @title  =  'Attendances'
        attendances_json  =  File.read("storage/#{ENV['place_code']}/fire_and_rescue/attendances.json")
        @attendances  =  JSON.parse(attendances_json)

        respond_to  do  |format|
            format.json  {  render  json:  @attendances  }
            format.xml  {  render  xml:  @attendances  }
            format.html  {  render  :attendances,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end
end
