class  Charts::EmissionsController  <  ApplicationController
    def  types
        @title  =  'Types'
        types_json  =  File.read("storage/#{ENV['place_code']}/emissions/type.json")
        types  =  JSON.parse(types_json)

        @carbon_dioxide  =  []
        @methane  =  []
        @nitrous_oxide  =  []
        @f_gases  =  []
        @labels  =  []

        types.sort_by{|p|  p["Year"].to_i}.each  do  |val|
            @labels  <<  val['Year'].to_i

            @carbon_dioxide  <<  val['CO2  Carbon  dioxide  total']
            @methane  <<  val['CH4  total  Methane']
            @nitrous_oxide  <<  val['N2O  total  Nitrous  oxide']
            @f_gases  <<  val['Fluorinated  gases  total']

        end

        respond_to  do  |format|
            format.html
        end
    end

    def  source
        @title  =  'Source'
        source_json  =  File.read("storage/#{ENV['place_code']}/emissions/source.json")
        source  =  JSON.parse(source_json)

        @labels  =  source.sort_by{|p|  p["Year"]}.collect{|s|  s['Year']}
        data  =  {}
        source.sort_by{|p|  p["Year"]}.each  do  |year|
            year.each  do  |key,  value|
                next  if  key  ==  'Year'
                data[key]  =  []  if  data[key].nil?
                data[key]  <<  value
            end
        end

        @data  =  []
        data.each  do  |k,v|
            @data  <<  {  name:  k,  data:  v  }
        end

        respond_to  do  |format|
            format.html
        end
    end
end
