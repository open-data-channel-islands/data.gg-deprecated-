class AddNightAndSkipToStopTime < ActiveRecord::Migration
  def change
    add_column :stop_times, :night, :bool
    add_column :stop_times, :skip, :bool
  end
end
