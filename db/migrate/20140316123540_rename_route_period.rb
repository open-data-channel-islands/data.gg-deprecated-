class RenameRoutePeriod < ActiveRecord::Migration
  def change
    rename_table :route_period, :route_periods
  end
end
