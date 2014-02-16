class CreateRouteStops < ActiveRecord::Migration
  def change
    create_table :route_stops do |t|
      t.integer :time
      t.integer :route_id
      t.integer :stop_id
      t.boolean :display

      t.timestamps
    end
  end
end
