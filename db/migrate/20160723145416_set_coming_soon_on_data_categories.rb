class SetComingSoonOnDataCategories < ActiveRecord::Migration[5.0]
  def change

    tides = DataCategory.find_by(name: 'Tides')
    tides.coming_soon = true
    tides.save!
    fuel = DataCategory.find_by(name: 'Fuel')
    fuel.coming_soon = true
    fuel.save!
    sports = DataCategory.find_by(name: 'Sports')
    sports.coming_soon = true
    sports.save!
    broadband = DataCategory.find_by(name: 'Broadband')
    broadband.coming_soon = true
    broadband.save!
    recycling = DataCategory.find_by(name: 'Recycling')
    recycling.coming_soon = true
    recycling.save!
    roadworks = DataCategory.find_by(name: 'Roadworks')
    roadworks.coming_soon = true
    roadworks.save!
    fishing = DataCategory.find_by(name: 'Fishing')
    fishing.coming_soon = true
    fishing.save!
  end
end
