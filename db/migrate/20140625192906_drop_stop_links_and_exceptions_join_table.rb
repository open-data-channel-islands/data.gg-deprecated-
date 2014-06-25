class DropStopLinksAndExceptionsJoinTable < ActiveRecord::Migration
  def change
    drop_table :stop_link_exceptions_stop_links
  end
end
