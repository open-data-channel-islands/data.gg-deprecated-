class DropUselessFieldFromStopLinks < ActiveRecord::Migration
  def change
    remove_column :stop_links, :route_id
    remove_column :stop_links, :stop_id
    remove_column :stop_links, :next_time_stop_link_id
    remove_column :stop_links, :next_place_stop_link_id
    remove_column :stop_links, :prev_time_stop_link_id
    remove_column :stop_links, :prev_place_stop_link_id
  end
end
