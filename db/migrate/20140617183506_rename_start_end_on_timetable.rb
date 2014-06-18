class RenameStartEndOnTimetable < ActiveRecord::Migration
  def change
    rename_column :timetables, :start, :start_date
    rename_column :timetables, :end, :end_date
  end
end
