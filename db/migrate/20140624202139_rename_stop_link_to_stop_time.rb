class RenameStopLinkToStopTime < ActiveRecord::Migration
  def change
    rename_table :stop_links, :stop_times
  end
end
