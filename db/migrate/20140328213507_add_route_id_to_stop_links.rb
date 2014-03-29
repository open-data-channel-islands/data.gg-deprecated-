class AddRouteIdToStopLinks < ActiveRecord::Migration
  def change
    add_column :stop_links, :route_id, :integer
  end
end
