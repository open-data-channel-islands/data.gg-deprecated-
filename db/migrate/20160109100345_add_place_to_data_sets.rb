class AddPlaceToDataSets < ActiveRecord::Migration
  def change
    add_reference :data_sets, :place, index: true, foreign_key: true
  end
end
