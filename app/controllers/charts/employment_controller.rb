class  Charts::EmploymentController  <  ApplicationController
    def  totals
        @title  =  'Totals'
        totals_json  =  File.read("storage/#{ENV['place_code']}/employment/totals.json")
        totals  =  JSON.parse(totals_json)

        @labels  =  totals.map  {|c|  c['Date  Taken']}.uniq
        @labels  =  @labels.sort_by{  |x|  Date.parse(x)  }
        @employed  =  []
        @unemployed  =  []
        @employers  =  []

        @labels.each  do  |period|
            total_for_period  =  totals.find  {  |t|  t['Date  Taken']  ==  period  }
            @employed  <<  (total_for_period  !=  nil  ?  total_for_period['Total  in  employment']  :  0)
            @unemployed  <<  (total_for_period  !=  nil  ?  total_for_period['Total  registered  unemployed']  :  0)
            @employers  <<  (total_for_period  !=  nil  ?  total_for_period['Employers']  :  0)
        end


    end
end
