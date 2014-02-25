class AddRouteStopsAndOriginToStopLinks < ActiveRecord::Migration
  def change
    add_column :stop_links, :origin_time, :integer
    add_column :stop_links, :route_stop_id, :integer
  end
end
