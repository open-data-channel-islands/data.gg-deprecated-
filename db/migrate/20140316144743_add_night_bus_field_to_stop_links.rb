class AddNightBusFieldToStopLinks < ActiveRecord::Migration
  def change
    add_column :stop_links, :night, :boolean
  end
end
