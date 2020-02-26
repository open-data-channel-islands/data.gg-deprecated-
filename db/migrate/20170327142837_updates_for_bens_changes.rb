class  UpdatesForBensChanges  <  ActiveRecord::Migration[5.0]
    def  change

        gg  =  Place.find_by(code:  'GG')

        prison_pop  =  DataSet.find_by(name:  'Prison  Population')
        prison_pop.update!(source_url:  'https://www.gov.gg/prison')

        waste_cat  =  DataCategory.find_by(name:  'Recycling')
        waste_cat.update!(coming_soon:  false,  name:  'Waste',  stub:  'waste',  desc:  'Waste  and  recycling')

        water_cat  =  DataCategory.find_by(name:  'Water')
        energy_cat  =  DataCategory.find_by(name:  'Energy')

#  energy
        DataSet.create!(place:  gg,  data_category:  energy_cat,
            name:  'Gas',  stub:  'gas',  desc:  'Gas  usage  from  1990',
            filename:  'energy/gas.json',  live:  false,  source_url:  'http://www.gov.gg/pru')

        DataSet.create!(place:  gg,  data_category:  energy_cat,
            name:  'Oil',  stub:  'oil',  desc:  'Oil  imports  since  2008',
            filename:  'energy/oil_imports.json',  live:  false,  source_url:  'http://www.gov.gg/pru')

        DataSet.create!(place:  gg,  data_category:  energy_cat,
            name:  'Renewable',  stub:  'renewable',  desc:  'Renewable  energy  since  2008',
            filename:  'energy/renewable_energy.json',  live:  false,  source_url:  'http://www.gov.gg/pru')


#  waste
        DataSet.create!(place:  gg,  data_category:  waste_cat,
            name:  'Commercial  and  Industrial',  stub:  'commercial-and-industrial',  desc:  'Commercial  and  industrial  waste  since  2008',
            filename:  'waste/commercial_and_industrial_waste.json',  live:  false,  source_url:  'http://www.gov.gg/pru')

        DataSet.create!(place:  gg,  data_category:  waste_cat,
            name:  'Construction  and  Demolition',  stub:  'construction-and-demolition',  desc:  'Construction  and  demolition  waste  since  2008',
            filename:  'waste/construction_and_demolition_waste.json',  live:  false,  source_url:  'http://www.gov.gg/pru')

        DataSet.create!(place:  gg,  data_category:  waste_cat,
            name:  'Household',  stub:  'household',  desc:  'Household  waste  since  2008',
            filename:  'waste/household_waste.json',  live:  false,  source_url:  'http://www.gov.gg/pru')

#  water
        DataSet.create!(place:  gg,  data_category:  water_cat,
            name:  'Nitrate  Concentration',  stub:  'nitrate-concentration',  desc:  'Nitrate  concentration  since  2008',
            filename:  'water/nitrate_concentration.json',  live:  false,  source_url:  'http://www.gov.gg/pru')

        DataSet.create!(place:  gg,  data_category:  water_cat,
            name:  'Pollution  Incidents',  stub:  'pollution-incidents',  desc:  'Incidents  of  pollution  since  2002',
            filename:  'water/pollution_incidents.json',  live:  false,  source_url:  'http://www.gov.gg/pru')

        DataSet.create!(place:  gg,  data_category:  water_cat,
            name:  'Unaccounted  Water',  stub:  'unaccounted-water',  desc:  'Water  unaccounted  for  since  2011',
            filename:  'water/unaccounted_water.json',  live:  false,  source_url:  'http://www.gov.gg/pru')

        DataSet.create!(place:  gg,  data_category:  water_cat,
            name:  'Water  Consumption',  stub:  'water-consumption',  desc:  'Water  consumption  since  1998',
            filename:  'water/water_consumption.json',  live:  false,  source_url:  'http://www.gov.gg/pru')

        DataSet.create!(place:  gg,  data_category:  water_cat,
            name:  'Water  Quality  Compliance',  stub:  'water-quality-compliance',  desc:  'Water  quality  compliance  since  2002',
            filename:  'water/water_quality_compliance.json',  live:  false,  source_url:  'http://www.gov.gg/pru')

        DataSet.create!(place:  gg,  data_category:  water_cat,
            name:  'Water  Storage',  stub:  'water-storage',  desc:  'Water  storage  since  2004',
            filename:  'water/water_storage.json',  live:  false,  source_url:  'http://www.gov.gg/pru')



    end
end
