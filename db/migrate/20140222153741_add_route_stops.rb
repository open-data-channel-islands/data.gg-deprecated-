class AddRouteStops < ActiveRecord::Migration
  def change
    create_table :route_stops do |t|
      t.references :route, index: true
      t.references :stop, index: true
      t.integer :index
    end
  end
end
