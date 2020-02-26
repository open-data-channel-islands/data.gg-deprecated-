require  'json'
class  Api::V10::EducationController  <  ApplicationController

    def  post16results
        @title  =  'Post  16  Results'
        post16results_json  =  File.read("storage/#{ENV['place_code']}/education/post16results.json")
        @post16results  =  JSON.parse(post16results_json)

        respond_to  do  |format|
            format.json  {  render  json:  @post16results  }
            format.xml  {  render  xml:  @post16results  }
            format.html  {  render  :post16results,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  gcse_overall
        @title  =  'GCSE  Overall'
        gcse_overall_json  =  File.read("storage/#{ENV['place_code']}/education/gcse_overall.json")
        @gcse_overall  =  JSON.parse(gcse_overall_json)

        respond_to  do  |format|
            format.json  {  render  json:  @gcse_overall  }
            format.xml  {  render  xml:  @gcse_overall  }
            format.html  {  render  :gcse_overall,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  gcse_school
        @title  =  'GCSE  School'
        gcse_school_json  =  File.read("storage/#{ENV['place_code']}/education/gcse_school.json")
        @gcse_school  =  JSON.parse(gcse_school_json)

        respond_to  do  |format|
            format.json  {  render  json:  @gcse_school  }
            format.xml  {  render  xml:  @gcse_school  }
            format.html  {  render  :gcse_school,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end

    def  students_in_uk
        @title  =  'GCSE  School'
        students_in_uk_json  =  File.read("storage/#{ENV['place_code']}/education/students_in_uk.json")
        @students_in_uk  =  JSON.parse(students_in_uk_json)

        respond_to  do  |format|
            format.json  {  render  json:  @students_in_uk  }
            format.xml  {  render  xml:  @students_in_uk  }
            format.html  {  render  :students_in_uk,  layout:  ((params[:layout].nil?  ||  params[:layout]  ==  'true')  ?  true  :  false)  }
        end
    end
end
