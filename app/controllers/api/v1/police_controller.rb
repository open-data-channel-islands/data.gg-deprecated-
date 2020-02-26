require  'json'

class  Api::V1::PoliceController  <  ApplicationController
    def  index
        respond_to  do  |format|
            format.html  {  render  :index  }
        end
    end

    def  crimes
        crime_json  =  File.read("storage/#{ENV['place_code']}/crime/crime.json")
        @crimes  =  JSON.parse(crime_json)
        @crimes.sort_by!  {  |c|  c['Year']  }

        respond_to  do  |format|
            format.json  {  render  json:  @crimes  }
            format.xml  {  render  xml:  @crimes  }
            format.html  {  render  html:  @crimes  }
        end
    end

    def  traffic
        traffic_json  =  File.read("storage/#{ENV['place_code']}/traffic/traffic.json")
        @traffic  =  JSON.parse(traffic_json)
        @traffic.sort_by!  {  |c|  c['Year']  }

        respond_to  do  |format|
            format.json  {  render  json:  @traffic  }
            format.xml  {  render  xml:  @traffic  }
            format.html  {  render  html:  @traffic  }
        end
    end

    def  traffic_collisions
        traffic_json  =  File.read("storage/#{ENV['place_code']}/traffic/traffic_collisions.json")
        @traffic  =  JSON.parse(traffic_json)
        @traffic.sort_by!  {  |c|  c['Year']  }

        respond_to  do  |format|
            format.json  {  render  json:  @traffic  }
            format.xml  {  render  xml:  @traffic  }
            format.html  {  render  html:  @traffic  }
        end
    end

    def  traffic_injuries
        traffic_json  =  File.read("storage/#{ENV['place_code']}/traffic/traffic_injuries.json")
        @traffic  =  JSON.parse(traffic_json)
        @traffic.sort_by!  {  |c|  c['Year']  }

        respond_to  do  |format|
            format.json  {  render  json:  @traffic  }
            format.xml  {  render  xml:  @traffic  }
            format.html  {  render  html:  @traffic  }
        end
    end

    def  traffic_classifications
        traffic_json  =  File.read("storage/#{ENV['place_code']}/traffic/traffic_classifications.json")
        @traffic  =  JSON.parse(traffic_json)
        @traffic.sort_by!  {  |c|  c['Year']  }

        respond_to  do  |format|
            format.json  {  render  json:  @traffic  }
            format.xml  {  render  xml:  @traffic  }
            format.html  {  render  html:  @traffic  }
        end
    end

end
