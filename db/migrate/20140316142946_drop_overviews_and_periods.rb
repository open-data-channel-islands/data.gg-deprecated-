class DropOverviewsAndPeriods < ActiveRecord::Migration
  def change
    drop_table :route_overviews
    drop_table :route_periods
  end
end
