class AddRoutePeriod < ActiveRecord::Migration
  def change
    create_table :route_period do |t|
      t.string :name
      t.integer :start_day
      t.integer :end_day
      t.text :description
      t.integer :route_overview_id

      t.timestamps
    end
  end
end
