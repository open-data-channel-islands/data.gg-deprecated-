class Charts::EducationController < ApplicationController
  
  
  
  def index
    
  end
  
  def post16results
    
    post16_json = File.read("storage/post16results.json")
    @post16_results = JSON.parse(post16_json)
    
    
    #######################
    ####### ALEVELS #######
    #######################
    
    # Just get the A-level result for now....
    alevel_results = @post16_results.find_all{|item| item["Type"] == "A Level"}
    
    colours = [["rgba(235,140,45,0.5)", "rgba(219,111,2,0.5)"],
               ["rgba(51,184,224,0.5)", "rgba(9,162,222,0.5)"],
               ["rgba(51,222,111,0.5)", "rgba(2,196,70,0.5)"]]
    
    # Labels are the grades
    @alevel_labels = alevel_results.uniq{|p| p["Grade"]}.collect{|p| p["Grade"]}

    @alevels = []
    @alevel_colour_keys = {}

    # Sort by years, so 2011-2012,2012-2013 etc.
    # Then group by those very years giving us key-value
    # pairs of years to result sets for those years
    alevel_results.sort_by{|p| p["Year"]}.group_by{ |p| p["Year"] }.each do |key,val|

       # Get leading colour, then delete it. Saves having to do random fetches
       # and avoids collision checks
       colour = colours[0]
       
       # Map the colour to the year. We can then loop through these in the view
       # to generate a chart legend showing which colour means what
       @alevel_colour_keys[colour] = key
       
       colours.delete_at(0)
       
       # For this specific year that we've grouped by
       result = val.sort_by{|p| @alevel_labels.index p["Grade"]}.collect{|p| p["Percent"]}
       
       hash = { :fillColor => colour[0], :strokeColor => colour[1],
         :pointColor => "rgba(100,100,100,1)", :pointStrokeColor => "#FFFFFF",
         :data => result }
         
       @alevels << hash
    end
    
    
    
    
    ####################
    ####### BTEC #######
    ####################
    btec_results = @post16_results.find_all{|item| item["Type"] == "BTEC"}
    
    colours = [["rgba(235,140,45,0.5)", "rgba(219,111,2,0.5)"],
               ["rgba(51,184,224,0.5)", "rgba(9,162,222,0.5)"],
               ["rgba(51,222,111,0.5)", "rgba(2,196,70,0.5)"]]
               
    @btec_labels = btec_results.uniq{|p| p["Grade"]}.collect{|p| p["Grade"]}
    @btecs = []
    @btec_colour_keys = {}
               
    btec_results.sort_by{|p| p["Year"]}.group_by{ |p| p["Year"] }.each do |key,val|
      
      # Get leading colour, then delete it. Saves having to do random fetches
      # and avoids collision checks
      colour = colours[0]
      
      # Map the colour to the year. We can then loop through these in the view
      # to generate a chart legend showing which colour means what
      @btec_colour_keys[colour] = key
      
      colours.delete_at(0)
      
      # For this specific year that we've grouped by
      result = val.sort_by{|p| @btec_labels.index p["Grade"]}.collect{|p| p["Percent"]}
      
      hash = { :fillColor => colour[0], :strokeColor => colour[1],
        :pointColor => "rgba(100,100,100,1)", :pointStrokeColor => "#FFFFFF",
        :data => result }
        
      @btecs << hash
                    
    end
    
  end
  
  def gcses_overall
    
  end
  
  def gcses_by_school
    
  end
end