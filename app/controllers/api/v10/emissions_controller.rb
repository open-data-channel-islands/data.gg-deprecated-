class  Api::V10::EmissionsController  <  ApplicationController
    def  types
        @title  =  'Types'
        type_json  =  File.read("storage/#{ENV['place_code']}/emissions/type.json")
        @types  =  JSON.parse(type_json)

        respond_to  do  |format|
            format.json  {  render  json:  @types  }
            format.xml  {  render  xml:  @types  }
            format.html  {  render  :types,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end
end