class AddTimetableToException < ActiveRecord::Migration
  def change
    add_column :stop_time_exceptions, :timetable_id, :integer
  end
end
