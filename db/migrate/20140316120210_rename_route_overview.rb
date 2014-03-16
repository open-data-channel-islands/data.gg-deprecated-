class RenameRouteOverview < ActiveRecord::Migration
  def change
    rename_table :route_overview, :route_overviews
  end
end
