class Charts::EducationController < ApplicationController
  
  
  
  def index
    
  end
  
  def post16results
    
    post16_json = File.read("storage/post16results.json")
    @post16_results = JSON.parse(post16_json)
    
    @post16_results = @post16_results.find_all{|item| item["Type"] == "A Level"}
    
    # Labels are the grades
    @labels = @post16_results.uniq{|p| p["Grade"]}.collect{|p| p["Grade"]}
    
    r = @post16_results.group_by{|result| result["Year"].to_s }

    @result_sets = []
    
    
    

    @post16_results.sort_by{|p| p["Year"]}
                   .group_by{ |p| p["Year"] }
                   .each do |key,val|

                     result = val.sort_by{|p| @labels.index p["Grade"]}.collect{|p| p["Percent"]}
                     
                     hash = { :fillColor => "rgba(50,50,0,0.8)", :strokeColor => "rgba(100,100,100,1)",
                       :pointColor => "rgba(100,100,100,1)", :pointStrokeColor => "#FFFFFF",
                       :data => result }
                       
                       @result_sets << hash
                     # Sort value by the labels
    end

    # Need many datasets, so get unique years, ensure they're ordered, then build!
    #@post16_results.uniq{ |p| p["Year"]}.collect{ |p| p["Year"] }.each do |item|
      
      # Would be something like 2012-2013
      
    #  @post16_results.sort_by do |p|
    #    if p
    #  end
      
   # end
    

    
   # @years = @post16_results.uniq { |p| p['Year'] }.collect { |p| p['Year'] }
  #  @months = ['January','February','March','April','May','June','July','August','September','October','November','December']
    # Create a hash so you have @bus_usage[year] containing an array of key-value pairs for month->value
   # @bus_usage = Hash[*@bus_usage.map { |k| [k['Year'], k] }.flatten]
    
    
    
    
  end
  
  def gcses_overall
    
  end
  
  def gcses_by_school
    
  end
end