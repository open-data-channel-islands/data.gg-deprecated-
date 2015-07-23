class Charts::TrafficController < ApplicationController

  def classifications
    @title = 'Classifications'
    classifications_json = File.read("storage/traffic_classifications.json")
    classifications = JSON.parse(classifications_json)

    @fatals = []
    @seriouses = []
    @slights = []
    @labels = []

    classifications.sort_by{|p| p["Year"].to_i}.each do |val|
      @labels << val['Year'].to_i

      @fatals << val['Fatal']
      @seriouses << val['Serious']
      @slights << val['Slight']
    end

    respond_to do |format|
      format.html
    end
  end

  def collisions
    @title = 'Collisions'
    collisions_json = File.read("storage/traffic_collisions.json")
    collisions = JSON.parse(collisions_json)

    @collisions = []
    @labels = []

    collisions.sort_by{|p| p["Year"].to_i}.each do |val|
      @labels << val['Year'].to_i
      @collisions << val['Collisions'].to_i
    end

    respond_to do |format|
      format.html
    end
  end

  def offences
    @title = 'Offences'

    traffic_json = File.read("storage/traffic.json")
    traffics = JSON.parse(traffic_json)
    traffics.sort_by! {|c| c['Year'].to_i }

    @labels = traffics.uniq { |p| p['Year'] }.collect { |p| p['Year'] }
    reporting_types = {
    'Driving on pavement' => ['Driving Vehicle On Footpath', 'Driving vehicle on footpath'],
    'Driving on mobile' => ['Driver Of Vehicle Using Mobile Telephone', 'Driver of vehicle using mobile telephone', 'Driving vehicle using mobile telephone'],
    'Fail To Stop After Accident' => ['Fail To Stop After Accident', 'Fail to stop after accident'],
    'Speeding' => ['Speeding Offences', 'Speeding offences'],
    'Traffic Lights - Fail To Comply' => ['Traffic Lights - Fail To Comply','Traffic lights - fail to comply'],
    'Drink Driving' => ['Drink drive offences (arrests)', 'DRINK /DRUG DRIVE OFFENCES (arrests)', 'Drink /drug Drive Offences (arrests)'],
    'Dangerous Driving' => ['Dangerous Driving', 'Dangerous driving'],
    'Driving Without Due Care And Attention' => ['Driving Without Due Care And Attention/Consideration', 'Driving Without Due Care And Attention/consideration', 'Driving without due care and attention/consideration']
    }  # Type name can changes between years, thanks Guernsey Police
    @results = []

    reporting_types.each do |reporting_name, data_type_names|
      p reporting_name
      result = []

      @labels.each do |year|
        year_value = 0

        traffics.each do |traffic|
          next if traffic['Year'] != year
          next if !data_type_names.include?(traffic['Offence'])

          p "#{traffic['Year']} - #{traffic['Offence']}"


          year_value = traffic['Count']
        end

        result << year_value
      end

      @results << { name: reporting_name, data: result }
    end
  end
end