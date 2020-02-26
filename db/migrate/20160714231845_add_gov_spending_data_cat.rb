class  AddGovSpendingDataCat  <  ActiveRecord::Migration[5.0]
    def  change

        gg  =  Place.find_by(code:  'GG')

        gov_spending  =  DataCategory.create!(name:  'Government  spending',  stub:  'government-spending',
            desc:  'Government  spending  since  2014',  image:  'i-798-filter-2x')

        DataSet.create!(place:  gg,  data_category:  gov_spending,
            name:  'Monetary  Amount',
            stub:  'monetary-amount',  desc:  'Government  spending  in  pounds  since  2014',
            filename:  'government_spending/monetary_amount.json',  live:  false,  source_url:  'https://www.gov.gg/data')

        DataSet.create!(place:  gg,  data_category:  gov_spending,
            name:  'Percentage',
            stub:  'percentage',  desc:  'Government  spending  in  percent  since  2014',
            filename:  'government_spending/percentage.json',  live:  false,  source_url:  'https://www.gov.gg/data')

        DataSet.create!(place:  gg,  data_category:  gov_spending,
            name:  'Per  Capita',
            stub:  'per-capita',  desc:  'Government  spending  per-capita  values  since  2014',
            filename:  'government_spending/per_capita.json',  live:  false,  source_url:  'https://www.gov.gg/data')
    end
end
