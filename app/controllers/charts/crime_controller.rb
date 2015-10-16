class Charts::CrimeController < ApplicationController

  def detected
    @title = 'Detected'
    collect_results('Detected')
    respond_to do |format|
      format.html
    end
  end

  def reported
    @title = 'Reported'
    collect_results('Reported')
    respond_to do |format|
      format.html
    end
  end

  def prison_population
    @title = 'Prison Population'
    prison_population_json = File.read("storage/#{ENV['place_code']}/crime/prison_population.json")
    prison_population = JSON.parse(prison_population_json)

    @labels = []
    @count = []

    prison_population.sort_by{ |p| p["Year"].to_i }.each do |val|
      @labels << val['Year'].to_i
      @count << val['Number of prisoners']
    end

    respond_to do |format|
      format.html
    end
  end

  def worried
    @title = 'Worried (2013)'
    worried_json = File.read("storage/#{ENV['place_code']}/crime/worried.json")
    worried = JSON.parse(worried_json)

    @percent = []
    worried.select{ |u| u['Year'] == 2013 }.each do |val|
      @percent << [ 'Very worried', val['Very worried'] ]
      @percent << [ 'Fairly worried', val['Fairly worried'] ]
      @percent << [ 'Not very worried', val['Not very worried'] ]
      @percent << [ 'Not at all worried', val['Not at all worried'] ]
    end

    respond_to do |format|
      format.html
    end
  end

  private

  def collect_results(field)
    crime_json = File.read("storage/#{ENV['place_code']}/crime/crime.json")
    crimes = JSON.parse(crime_json)
    crimes.sort_by! {|c| c['Year'].to_i }

    @labels = crimes.uniq { |p| p['Year'] }.collect { |p| p['Year'] }
    reporting_types = {
    'Rape' => ['Rape'],
    'Robbery' => ['Robbery', 'Theft - Robbery'],
    'Criminal Damage' => ['Criminal Damage', 'Criminal Damage & Threats','Criminal Damage/Threats & Arson', 'Criminal Damage/threats & arson', 'Criminal damage/threats & arson'],
    'Common Assault' => ['Common Assault', 'Assault - Common', 'Assault - Common & Threats to kill'],
    'Fraud' => ['False Accounting & Destroy Docs', 'Fraud/False Accounting', 'Fraud/false accounting'],
    'Burglary Dwelling' => ['Burglary Dwelling', 'Burglary dwelling'],
    'Shoplifting' => ['Shoplifting','Theft - shoplifting', 'Theft - Shoplifting']
    }  # Type name can changes between years, thanks Guernsey Police
    @results = []

    reporting_types.each do |reporting_name, data_type_names|
      p reporting_name
      result = []

      @labels.each do |year|
        year_value = 0

        crimes.each do |crime|
          next if crime['Year'] != year
          next if !data_type_names.include?(crime['Offence'])

          p "#{crime['Year']} - #{crime['Offence']}"


          year_value = crime[field]
        end

        result << year_value
      end

      @results << { name: reporting_name, data: result }
    end
  end

end
