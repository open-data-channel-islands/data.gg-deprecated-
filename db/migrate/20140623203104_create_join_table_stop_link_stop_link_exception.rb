class CreateJoinTableStopLinkStopLinkException < ActiveRecord::Migration
  def change
    create_join_table :stop_links, :stop_link_exceptions do |t|
      # t.index [:stop_link_id, :stop_link_exception_id]
      # t.index [:stop_link_exception_id, :stop_link_id]
    end
  end
end
