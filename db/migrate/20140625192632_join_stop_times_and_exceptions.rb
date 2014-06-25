class JoinStopTimesAndExceptions < ActiveRecord::Migration
  def change
    create_join_table :stop_times, :stop_time_exceptions do |t|
      # t.index [:stop_link_id, :stop_link_exception_id]
      # t.index [:stop_link_exception_id, :stop_link_id]
    end
  end
end
