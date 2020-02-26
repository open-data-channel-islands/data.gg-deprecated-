class  Api::V10::PopulationController  <  ApplicationController

    def  population
        @title  =  'Population'
        population_json  =  File.read("storage/#{ENV['place_code']}/population/population.json")
        @population  =  JSON.parse(population_json)

        respond_to  do  |format|
            format.json  {  render  json:  @population  }
            #  We  use  a  template  builder  for  this  one  as  the  data  column  names  have  numbers  in  them
            #  and  XML  sucks.
            format.xml  {  @population  }
            format.html  {  render  :population,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  age
        json_data  =  File.read("storage/#{ENV['place_code']}/population/age.json")
        @age  =  JSON.parse(json_data)
        @title  =  'Age'

        respond_to  do  |format|
            format.json  {  render  json:  @age  }
            #  We  use  a  template  builder  for  this  one  as  the  data  column  names  have  numbers  in  them
            #  and  XML  sucks.
            format.xml  {  @age  }
            format.html  {  render  :age,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  age_female
        json_data  =  File.read("storage/#{ENV['place_code']}/population/age_female.json")
        @age  =  JSON.parse(json_data)
        @title  =  'Age  Female'

        respond_to  do  |format|
            format.json  {  render  json:  @age  }
            #  We  use  a  template  builder  for  this  one  as  the  data  column  names  have  numbers  in  them
            #  and  XML  sucks.
            format.xml  {  render  :age  }
            format.html  {  render  :age,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  age_male
        json_data  =  File.read("storage/#{ENV['place_code']}/population/age_male.json")
        @age  =  JSON.parse(json_data)
        @title  =  'Age  Male'

        respond_to  do  |format|
            format.json  {  render  json:  @age  }
            #  We  use  a  template  builder  for  this  one  as  the  data  column  names  have  numbers  in  them
            #  and  XML  sucks.
            format.xml  {  render  :age  }
            format.html  {  render  :age,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  birthplace
        @title  =  'Birthplace'
        json_data  =  File.read("storage/#{ENV['place_code']}/population/birthplace.json")
        @birthplace  =  JSON.parse(json_data)

        respond_to  do  |format|
            format.json  {  render  json:  @birthplace  }
            format.xml  {  render  xml:  @birthplace  }
            format.html  {  render  :birthplace,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  changes
        @title  =  'Changes'
        json_data  =  File.read("storage/#{ENV['place_code']}/population/changes.json")
        @changes  =  JSON.parse(json_data)

        respond_to  do  |format|
            format.json  {  render  json:  @changes  }
            format.xml  {  render  xml:  @changes  }
            format.html  {  render  :changes,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  district
        @title  =  'District'
        json_data  =  File.read("storage/#{ENV['place_code']}/population/district.json")
        @district  =  JSON.parse(json_data)

        respond_to  do  |format|
            format.json  {  render  json:  @district  }
            format.xml  {  render  xml:  @district  }
            format.html  {  render  :district,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  parish
        @title  =  'Parish'
        json_data  =  File.read("storage/#{ENV['place_code']}/population/parish.json")
        @parish  =  JSON.parse(json_data)

        respond_to  do  |format|
            format.json  {  render  json:  @parish  }
            format.xml  {  render  xml:  @parish  }
            format.html  {  render  :parish,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

end
