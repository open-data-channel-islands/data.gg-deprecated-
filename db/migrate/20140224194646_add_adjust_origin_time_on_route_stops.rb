class AddAdjustOriginTimeOnRouteStops < ActiveRecord::Migration
  def change
    remove_column :stop_links, :origin_time
    add_column :stop_links, :origin_stop_link_id, :integer
  end
end
