class ChangeTimetableDates < ActiveRecord::Migration
  def change
    rename_column :timetables, :effective_date, :start
    change_column :timetables, :start, :date
    add_column :timetables, :end, :date
  end
end
