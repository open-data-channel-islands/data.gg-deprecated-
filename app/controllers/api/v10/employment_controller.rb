class  Api::V10::EmploymentController  <  ApplicationController
    def  totals
        @title  =  'Totals'
        totals_json  =  File.read("storage/#{ENV['place_code']}/employment/totals.json")
        @totals  =  JSON.parse(totals_json)

        respond_to  do  |format|
            format.json  {  render  json:  @totals  }
            format.xml  {  render  xml:  @totals  }
            format.html  {  render  :totals,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end
end
