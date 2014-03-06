class RenamedIndexToIdxOnRouteStop < ActiveRecord::Migration
  def change
    rename_column :route_stops, :index, :idx
  end
end
