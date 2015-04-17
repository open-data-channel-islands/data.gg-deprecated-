require 'chart_colours'
class Charts::EducationController < ApplicationController

  def post16results

    post16_json = File.read("storage/post16results.json")
    @post16_results = JSON.parse(post16_json)

    # Just get the A-level result for now....
    alevel_results = @post16_results.find_all{|item| item["Type"] == "A Level"}

    # Labels are the grades
    @labels = ['U','E','D','C','B','A','A*']
    @alevels = []

    colour_keys = {
      '2010-2011' => ChartColours::COLOURS[0],
      '2011-2012' => ChartColours::COLOURS[1],
      '2012-2013' => ChartColours::COLOURS[2],
      '2013-2014' => ChartColours::COLOURS[3],
    }
    @year_colours = { }

    alevel_results.sort_by{|p| p["Year"][0..4]}.group_by{ |p| p["Year"] }.each do |key,val|

      result = []
      @labels.each do |lbl|
        value_for_lbl = val.find { |v| v['Grade'] == lbl }
        result << (value_for_lbl != nil ? value_for_lbl['Percent'] : 0)
      end

      fill = "rgba(#{colour_keys[key].join(',')})"
      stroke ="rgba(#{ChartColours::darken_color(colour_keys[key]).join(',')})"

      @year_colours[key] = [fill,stroke]

       hash = { :fillColor => fill, :strokeColor => stroke, :data => result }

         @alevels << hash
       end

     end

  def post16results_btec

    post16_json = File.read("storage/post16results.json")
    @post16_results = JSON.parse(post16_json)

    btec_results = @post16_results.find_all{|item| item["Type"] == "BTEC" && item['Year'] != '2010-2011' && item['Year'] != '2011-2012' }

    @labels = ['Ungraded', 'Pass', 'Merit', 'Distinction']
    @btecs = []
    colour_keys = {
      '2010-2011' => ChartColours::COLOURS[0],
      '2011-2012' => ChartColours::COLOURS[1],
      '2012-2013' => ChartColours::COLOURS[2],
      '2013-2014' => ChartColours::COLOURS[3],
    }
    @year_colours = { }

    btec_results.sort_by{|p| p["Year"][0..4]}.group_by{ |p| p["Year"] }.each do |key,val|

      result = []
      @labels.each do |lbl|
        value_for_lbl = val.find { |v| v['Grade'] == lbl }
        result << (value_for_lbl != nil ? value_for_lbl['Percent'] : 0)
      end

      fill = "rgba(#{colour_keys[key].join(',')})"
      stroke ="rgba(#{ChartColours::darken_color(colour_keys[key]).join(',')})"

      @year_colours[key] = [fill,stroke]

      hash = { :fillColor => fill, :strokeColor => stroke, :data => result }

        @btecs << hash

      end

    end



    def gcses_overall

      gcses_json = File.read("storage/gcse_overall.json")
      gcses_overall = JSON.parse(gcses_json)

      @gcse_labels = [ '5+ A*– C (including English and Maths)' ]
      @gcse_year_colors = { }

      @results = []
      gcse_colour_keys = {
        2009 => ChartColours::COLOURS[0],
        2010 => ChartColours::COLOURS[1],
        2011 => ChartColours::COLOURS[2],
        2012 => ChartColours::COLOURS[3],
        2013 => ChartColours::COLOURS[4],
        2014 => ChartColours::COLOURS[5]
      }

    # Sort by years, so 2011-2012,2012-2013 etc.
    # Then group by those very years giving us key-value
    # pairs of years to result sets for those years
    gcses_overall.sort_by{|p| p["Year"]}.group_by{ |p| p["Year"] }.each do |key,val|
      result = []
      @gcse_labels.each do |lbl|
        value_for_lbl = val.find { |v| v['Result'] == lbl }
        result << (value_for_lbl != nil ? value_for_lbl['Percent'] : 0)
      end

      fill = "rgba(#{gcse_colour_keys[key].join(',')})"
      stroke ="rgba(#{ChartColours::darken_color(gcse_colour_keys[key]).join(',')})"

      @gcse_year_colors[key] = [fill,stroke]

      hash = {
        :fillColor => fill,
        :strokeColor => stroke,
        :data => result
      }
      @results << hash
    end


  end

  def gcses_by_school

    gcses_json = File.read("storage/gcse_school.json")
    gcses_by_school = JSON.parse(gcses_json)

    # Labels are the grades
    @years = [
      '2010-2011',
      '2011-2012',
      '2012-2013',
      '2013-2014'
    ]

    @schools = gcses_by_school.collect { |s| s['School'] }.uniq!

    @school_colours = { }

    @results = []
    gcse_colour_keys = Hash[@schools.each_with_index.map { |s,i| [s, ChartColours::COLOURS[i]] }]

    gcses_by_school.sort_by{|p| p["Year"][0..4]}.group_by{ |p| p["School"] }.each do |school, val|

      result = []
      @years.each do |lbl|
        value_for_lbl = val.find { |v| v['Year'] == lbl && v['Result'] == '% 5+ A*– C GCSEs including English and Maths or equivalent' }
        result << (value_for_lbl != nil ? value_for_lbl['Percent'] : 0)
      end

      fill = "rgba(#{gcse_colour_keys[school].join(',')})"
      stroke ="rgba(#{ChartColours::darken_color(gcse_colour_keys[school]).join(',')})"
      @school_colours[school] = [fill,stroke]

      transparent = []
      transparent << gcse_colour_keys[school][0]
      transparent << gcse_colour_keys[school][1]
      transparent << gcse_colour_keys[school][2]
      transparent << "0" #gcse_colour_keys[school][3]
      transparent_fill = "rgba(#{transparent.join(',')})"

      hash = {
        :fillColor => transparent_fill,
        :strokeColor => stroke,
        :pointColor => fill,
        :pointStrokeColor => stroke,
        :data => result
      }

      @results << hash
    end
  end
end