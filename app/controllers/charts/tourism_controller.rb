class  Charts::TourismController  <  ApplicationController
    def  cruises
        @title  =  'Cruises'
        cruises_json  =  File.read("storage/#{ENV['place_code']}/tourism/cruises.json")
        cruises  =  JSON.parse(cruises_json)

        @labels  =  []
        count_dict  =  {}

        cruises.each  do  |c|
            @labels  <<  c['Date'][3..7].to_s
        end
        @labels.uniq!

        cruises.each  do  |val|
            label  =  val['Date'][3..7].to_s

            if  count_dict[label].nil?
                count_dict[label]  =  val['No.  of  cruise  passengers'].to_i
            else
                count_dict[label]  +=  val['No.  of  cruise  passengers'].to_i
            end
        end

        @count  =  []
        count_dict.keys.sort.each  do  |key|
            @count  <<  count_dict[key]
        end
    end

    def  air_vs_sea_ann
        @title  =  'Air  vs  Sea'
        air_by_month_json  =  File.read("storage/#{ENV['place_code']}/tourism/air_by_month.json")
        air_by_month  =  JSON.parse(air_by_month_json)

        sea_by_month_json  =  File.read("storage/#{ENV['place_code']}/tourism/sea_by_month.json")
        sea_by_month  =  JSON.parse(sea_by_month_json)

        @labels  =  []
        @air  =  []
        air_by_month.sort_by{  |p|  p['Year'].to_i  }.each  do  |val|
            @labels  <<  val['Year'].to_i
            total  =  0
            total  +=  val['January']
            total  +=  val['February']
            total  +=  val['March']
            total  +=  val['April']
            total  +=  val['May']
            total  +=  val['June']
            total  +=  val['July']
            total  +=  val['August']
            total  +=  val['September']
            total  +=  val['October']
            total  +=  val['November']
            total  +=  val['December']
            @air  <<  total
        end

        @sea  =  []
        sea_by_month.sort_by{  |p|  p['Year'].to_i  }.each  do  |val|
            total  =  0
            total  +=  val['January']
            total  +=  val['February']
            total  +=  val['March']
            total  +=  val['April']
            total  +=  val['May']
            total  +=  val['June']
            total  +=  val['July']
            total  +=  val['August']
            total  +=  val['September']
            total  +=  val['October']
            total  +=  val['November']
            total  +=  val['December']
            @sea  <<  total
        end

        respond_to  do  |format|
            format.html
        end
    end
end
