class RenameRouteStopsToRouteStopTimes < ActiveRecord::Migration
  def change
    rename_table :route_stops, :route_stop_times
  end
end
