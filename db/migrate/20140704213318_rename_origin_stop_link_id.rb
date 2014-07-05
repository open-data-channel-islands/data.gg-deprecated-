class RenameOriginStopLinkId < ActiveRecord::Migration
  def change
    rename_column :stop_times, :origin_stop_link_id, :origin_stop_time_id
  end
end
