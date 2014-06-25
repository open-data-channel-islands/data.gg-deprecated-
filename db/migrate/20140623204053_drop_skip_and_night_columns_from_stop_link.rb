class DropSkipAndNightColumnsFromStopLink < ActiveRecord::Migration
  def change
    remove_column :stop_links, :skip
    remove_column :stop_links, :night
  end
end
