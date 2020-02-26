class  Api::V10::OverseasAidController  <  ApplicationController
    def  contributions
        @title  =  'Contributions'
        contributions_json  =  File.read("storage/#{ENV['place_code']}/overseas_aid/contributions.json")
        @contributions  =  JSON.parse(contributions_json)

        respond_to  do  |format|
            format.json  {  render  json:  @contributions  }
            format.xml  {  render  xml:  @contributions  }
            format.html  {  render  :contributions,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end
end
