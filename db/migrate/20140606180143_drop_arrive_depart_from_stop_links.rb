class DropArriveDepartFromStopLinks < ActiveRecord::Migration
  def change
    remove_column :stop_links, :arrive
    remove_column :stop_links, :depart
  end
end
