class RenameStopLinkExceptionsToExceptions < ActiveRecord::Migration
  def change
    rename_table :stop_link_exceptions, :exceptions
  end
end
