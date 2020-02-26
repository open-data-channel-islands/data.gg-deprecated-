class  ReplaceGovSpendingDataSets  <  ActiveRecord::Migration[5.0]
    def  change
        gg  =  Place.find_by(code:  'GG')

        gov_spending  =  DataCategory.find_by(stub:  'government-spending')

        monetary_amount  =  DataSet.find_by(stub:  'monetary-amount')
        monetary_amount.destroy

        percentage  =  DataSet.find_by(stub:  'percentage')
        percentage.destroy

        per_capita  =  DataSet.find_by(stub:  'per-capita')
        per_capita.destroy

        DataSet.create!(place:  gg,  data_category:  gov_spending,
            name:  'Breakdown',
            stub:  'breakdown',  desc:  'Government  spending  breakdown  from  2014',
            filename:  'government_spending/breakdown.json',  live:  false,  source_url:  'https://www.gov.gg/data')


    end
end
