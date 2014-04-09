class AddDefaultToDisplayOnRouteStops < ActiveRecord::Migration
  def change
    change_column :route_stops, :display, :boolean, :default => false
  end
end
