class AddStopLinksToRouteStop < ActiveRecord::Migration
  def change
    add_column :route_stops, :next_time_stop_link_id, :integer
    add_column :route_stops, :next_place_stop_link_id, :integer
    add_column :route_stops, :skip, :boolean
    add_column :route_stops, :arrive, :boolean
    add_column :route_stops, :depart, :boolean
  end
end
