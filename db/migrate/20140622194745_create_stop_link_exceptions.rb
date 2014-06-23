class CreateStopLinkExceptions < ActiveRecord::Migration
  def change
    create_table :stop_link_exceptions do |t|
      t.string :name
      t.string :colour

      t.timestamps
    end
  end
end
