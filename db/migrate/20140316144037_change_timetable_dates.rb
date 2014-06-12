class ChangeTimetableDates < ActiveRecord::Migration
  def change
    rename_column :timetables, :effective_date, :start
    remove_column :timetables, :start
    add_column :timetables, :start, :date
    add_column :timetables, :end, :date
  end
end
