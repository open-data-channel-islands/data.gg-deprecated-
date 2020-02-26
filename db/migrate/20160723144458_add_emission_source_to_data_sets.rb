class  AddEmissionSourceToDataSets  <  ActiveRecord::Migration[5.0]
    def  change

        gg  =  Place.find_by(code:  'GG')
        emissions  =  DataCategory.find_by(name:  'Emissions')

        DataSet.create!(place:  gg,  data_category:  emissions,
        name:  'Source',
        stub:  'source',  desc:  'Percentage  contribution  of  emissions  by  source  since  1990',
        filename:  'emissions/source.json',  live:  false,  source_url:  'https://www.gov.gg/data')

    end
end
