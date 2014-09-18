class CreatePlaceOfInterests < ActiveRecord::Migration
  def change
    create_table :place_of_interests do |t|
      t.string :name
      t.decimal :lat
      t.decimal :lng
      t.string :description

      t.timestamps
    end
  end
end
