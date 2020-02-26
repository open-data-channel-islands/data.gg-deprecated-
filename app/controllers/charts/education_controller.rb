require  'chart_colours'
class  Charts::EducationController  <  ApplicationController

    def  post16results
        @title  =  'A-Level  Results'
        post16_json  =  File.read("storage/#{ENV['place_code']}/education/post16results.json")
        post16_results  =  JSON.parse(post16_json)

        #  Just  get  the  A-level  result  for  now....
        alevel_results  =  post16_results.find_all{|item|  item["Type"]  ==  "A  Level"}

        #  Labels  are  the  grades
        @labels  =  ['U','E','D','C','B','A','A*']
        @results  =  []

        alevel_results.sort_by{|p|  p["Year"][0..4]}.group_by{  |p|  p["Year"]  }.each  do  |key,val|
            result  =  []
            @labels.each  do  |lbl|
                value_for_lbl  =  val.find  {  |v|  v['Grade']  ==  lbl  }
                result  <<  (value_for_lbl  !=  nil  ?  value_for_lbl['Percent']  :  0)
            end

            @results  <<  {  name:  key,  data:  result  }
        end
    end

    def  post16results_btec
        @title  =  'BTEC  Results'
        post16_json  =  File.read("storage/#{ENV['place_code']}/education/post16results.json")
        post16_results  =  JSON.parse(post16_json)

        btec_results  =  post16_results.find_all{|item|  item["Type"]  ==  "BTEC"  &&  item['Year']  !=  '2010-2011'  &&  item['Year']  !=  '2011-2012'  }

        @labels  =  ['Ungraded',  'Pass',  'Merit',  'Distinction']
        @results  =  []
        btec_results.sort_by{|p|  p["Year"][0..4]}.group_by{  |p|  p["Year"]  }.each  do  |key,val|

            result  =  []
            @labels.each  do  |lbl|
                value_for_lbl  =  val.find  {  |v|  v['Grade']  ==  lbl  }
                result  <<  (value_for_lbl  !=  nil  ?  value_for_lbl['Percent']  :  0)
            end

            @results  <<  {  name:  key,  data:  result  }
        end
    end

    def  gcses_overall
        @title  =  'GCSE  Overall'

        gcses_json  =  File.read("storage/#{ENV['place_code']}/education/gcse_overall.json")
        gcses_overall  =  JSON.parse(gcses_json)

        @labels  =  [  '5+  A*–  C  (including  English  and  Maths)'  ]
        @results  =  []

        gcses_overall.sort_by{|p|  p["Year"]}.group_by{  |p|  p["Year"]  }.each  do  |key,val|
            result  =  []
            @labels.each  do  |lbl|
                value_for_lbl  =  val.find  {  |v|  v['Result']  ==  lbl  }
                result  <<  (value_for_lbl  !=  nil  ?  value_for_lbl['Percent']  :  0)
            end

            @results  <<  {  name:  key,  data:  result  }
        end


    end

    def  gcses_by_school
        @title  =  'GCSE  By  School'
        gcses_json  =  File.read("storage/#{ENV['place_code']}/education/gcse_school.json")
        gcses_by_school  =  JSON.parse(gcses_json)

        @labels  =  [
            '2010-2011',
            '2011-2012',
            '2012-2013',
            '2013-2014',
            '2014-2015'
        ]
        @results  =  []
        gcses_by_school.sort_by{|p|  p["Year"][0..4]}.group_by{  |p|  p["School"]  }.each  do  |school,  val|
            result  =  []
            @labels.each  do  |lbl|
                value_for_lbl  =  val.find  {  |v|  v['Year']  ==  lbl  &&  v['Result']  ==  '%  5+  A*–  C  GCSEs  including  English  and  Maths  or  equivalent'  }
                result  <<  (value_for_lbl  !=  nil  ?  value_for_lbl['Percent']  :  0)
            end
            @results  <<  {  name:  school,  data:  result  }
        end
    end

    def  students_in_uk
        @title  =  'Students  in  the  UK'
        students_in_uk_json  =  File.read("storage/#{ENV['place_code']}/education/students_in_uk.json")
        students_in_uk  =  JSON.parse(students_in_uk_json)

        @labels  =  []
        @undergrad  =  []
        @postgrad  =  []
        @other  =  []

        students_in_uk.sort_by{  |p|  p["Year"].to_i  }.each  do  |val|
            @labels  <<  val['Year'].to_i
            @undergrad  <<  val['Undergraduate']
            @postgrad  <<  val['Postgraduate']
            @other  <<  val['Other  higher  education']
        end

        respond_to  do  |format|
            format.html
        end
    end
end