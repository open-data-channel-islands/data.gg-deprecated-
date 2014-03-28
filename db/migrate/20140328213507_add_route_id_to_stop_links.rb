class AddRouteIdToStopLinks < ActiveRecord::Migration
  def change
    add_column :routes, :route_id, :integer
  end
end
