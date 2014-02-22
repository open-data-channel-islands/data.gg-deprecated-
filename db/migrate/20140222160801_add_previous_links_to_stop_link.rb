class AddPreviousLinksToStopLink < ActiveRecord::Migration
  def change
    add_column :stop_links, :prev_time_stop_link_id, :integer, references: :stop_links
    add_column :stop_links, :prev_place_stop_link_id, :integer, references: :stop_links
  end
end
