class RemoveDisplayFromStopLinks < ActiveRecord::Migration
  def change
    remove_column :stop_links, :display
  end
end
