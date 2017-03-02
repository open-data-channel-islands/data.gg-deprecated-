class ActivateTidesArea < ActiveRecord::Migration[5.0]
  def change

    gg = Place.find_by(code: 'GG')

    tides_category = DataCategory.find_by(name: 'Tides')
    tides_category.update!(coming_soon: false, desc: 'Daily tidal data')

    DataSet.create!(place: gg, data_category: tides_category,
      name: 'Tides',
      stub: 'tides', desc: 'Daily tidal data',
      filename: 'tides/tides.json', live: false, source_url: 'https://gov.gg/tides')

  end
end
