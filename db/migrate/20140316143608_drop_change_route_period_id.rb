class DropChangeRoutePeriodId < ActiveRecord::Migration
  def change
    rename_column :routes, :route_period_id, :timetable_id
  end
end
