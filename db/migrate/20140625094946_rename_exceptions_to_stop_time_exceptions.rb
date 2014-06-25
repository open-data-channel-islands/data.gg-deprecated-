class RenameExceptionsToStopTimeExceptions < ActiveRecord::Migration
  def change
    rename_table :exceptions, :stop_time_exceptions
  end
end
