require  'json'

module  Api
    class  Api::V10::HousingController  <  ApplicationController

        def  local_prices
            @title  =  'Local  Prices'
            houses_json  =  File.read("storage/#{ENV['place_code']}/houses/local_prices.json")
            @house_prices  =  JSON.parse(houses_json)

            respond_to  do  |format|
                format.json  {  render  json:  @house_prices  }
                format.xml  {  render  xml:  @house_prices  }
                format.html  {  render  :local_prices,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
            end
        end

        def  open_prices
            @title  =  'Open  Prices'
            houses_json  =  File.read("storage/#{ENV['place_code']}/houses/open_prices.json")
            @house_prices  =  JSON.parse(houses_json)

            respond_to  do  |format|
                format.json  {  render  json:  @house_prices  }
                format.xml  {  render  xml:  @house_prices  }
                format.html  {  render  :open_prices,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
            end
        end

        def  bedrooms
            @title  =  'Bedrooms'
            houses_json  =  File.read("storage/#{ENV['place_code']}/houses/bedrooms.json")
            @bedrooms  =  JSON.parse(houses_json)

            respond_to  do  |format|
                format.json  {  render  json:  @bedrooms  }
                format.xml  {  @bedrooms  }
                format.html  {  render  :bedrooms,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
            end
        end

        def  types
            @title  =  'Types'
            houses_json  =  File.read("storage/#{ENV['place_code']}/houses/types.json")
            @types  =  JSON.parse(houses_json)

            respond_to  do  |format|
                format.json  {  render  json:  @types  }
                format.xml  {  render  xml:  @types  }
                format.html  {  render  :types,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
            end
        end

        def  units
            @title  =  'Units'
            houses_json  =  File.read("storage/#{ENV['place_code']}/houses/units.json")
            @units  =  JSON.parse(houses_json)

            respond_to  do  |format|
                format.json  {  render  json:  @units  }
                format.xml  {  render  xml:  @units  }
                format.html  {  render  :units,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
            end
        end

    end
end