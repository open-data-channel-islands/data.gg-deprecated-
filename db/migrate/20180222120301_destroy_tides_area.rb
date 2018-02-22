class DestroyTidesArea < ActiveRecord::Migration[5.1]
  def change
    gg = Place.find_by(code: 'GG')

    tides_category = DataCategory.find_by(name: 'Tides')
    if !tides_category.nil?
      tides_category.destroy
    end

    tides_set = DataSet.find_by(name: 'Tides')
    if !tides_set.nil?
      tides_set.destroy
    end
  end
end
