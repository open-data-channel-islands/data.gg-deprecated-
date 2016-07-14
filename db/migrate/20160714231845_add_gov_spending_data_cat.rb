class AddGovSpendingDataCat < ActiveRecord::Migration[5.0]
  def change

    gg = Place.find_by(code: 'GG')

    gov_spending = DataCategory.create!(name: 'Government spending', stub: 'government-spending',
      desc: 'Government spending since 2015', image: 'i-798-filter-2x')

    DataSet.create!(place: gg, data_category: gov_spending, name: 'Government spending',
      stub: 'government-spending', desc: 'Government spending since 2015',
      filename: 'government-spending/government_spending.json', live: false, source_url: 'https://www.gov.gg/data')
  end
end
