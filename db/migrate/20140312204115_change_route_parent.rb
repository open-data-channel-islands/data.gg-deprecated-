class ChangeRouteParent < ActiveRecord::Migration
  def change
    rename_column :routes, :timetable_id, :route_period_id
  end
end
