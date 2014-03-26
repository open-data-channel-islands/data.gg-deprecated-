class AddDisplayToRouteStops < ActiveRecord::Migration
  def change
    add_column :route_stops, :display, :boolean
  end
end
