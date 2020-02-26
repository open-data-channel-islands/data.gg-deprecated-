class  SetComingSoonOnDataCategories  <  ActiveRecord::Migration[5.0]
    def  change
        DataCategory.reset_column_information
        tides  =  DataCategory.find_by(name:  'Tides')
        tides.update!(coming_soon:  true)
        fuel  =  DataCategory.find_by(name:  'Fuel')
        fuel.update!(coming_soon:  true)
        sports  =  DataCategory.find_by(name:  'Sports')
        sports.update!(coming_soon:  true)
        broadband  =  DataCategory.find_by(name:  'Broadband')
        broadband.update!(coming_soon:  true)
        recycling  =  DataCategory.find_by(name:  'Recycling')
        recycling.update!(coming_soon:  true)
        roadworks  =  DataCategory.find_by(name:  'Roadworks')
        roadworks.update!(coming_soon:  true)
        fishing  =  DataCategory.find_by(name:  'Fishing')
        fishing.update!(coming_soon:  true)
    end
end
