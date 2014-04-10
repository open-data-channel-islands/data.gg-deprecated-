class AddCurrentVersionToTimetable < ActiveRecord::Migration
  def change
    add_column :timetables, :current_version, :int, :default => 0
  end
end
