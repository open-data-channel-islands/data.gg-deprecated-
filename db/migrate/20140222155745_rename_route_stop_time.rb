class RenameRouteStopTime < ActiveRecord::Migration
  def change
    rename_table :route_stop_times, :stop_links
  end
end
