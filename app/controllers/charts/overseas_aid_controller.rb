class  Charts::OverseasAidController  <  ApplicationController
    def  contributions
        @title  =  'Contributions'
        contributions_json  =  File.read("storage/#{ENV['place_code']}/overseas_aid/contributions.json")
        contributions  =  JSON.parse(contributions_json)

        @labels  =  []

        @africa_aid  =  []
        @africa_emergency  =  []
        @eu_aid  =  []
        @eu_emergency  =  []
        @india_aid  =  []
        @india_emergency  =  []
        @latin_aid  =  []
        @latin_emergency  =  []
        @asia_aid  =  []
        @asia_emergency  =  []
        @mid_east_aid  =  []
        @mid_east_emergency  =  []

        contributions.sort_by{  |p|  p['Year']  }.each  do  |val|
            @labels  <<  val['Year'].to_s
            @africa_aid  <<  val['Africa  Aid']
            @africa_emergency  <<  val['Africa  Emergency  Relief']
            @eu_aid  <<  val['Europe  Aid']
            @eu_emergency  <<  val['Europe  Emergency  Relief']
            @india_aid  <<  val['Indian  Sub-Continent  Aid']
            @india_emergency  <<  val['Indian  Sub-Continent  Emergency  Relief']
            @latin_aid  <<  val['Latin  America  and  Caribbean  Aid']
            @latin_emergency  <<  val['Latin  America  and  Caribbean  Emergency  Relief']
            @asia_aid  <<  val['Other  Asia  and  Pacific  Aid']
            @asia_emergency  <<  val['Other  Asia  and  Pacific  Emergency  Relief']
            @mid_east_aid  <<  val['Middle  East  Aid']
            @mid_east_emergency  <<  val['Middle  East  Emergency  Relief']
        end
    end
end
