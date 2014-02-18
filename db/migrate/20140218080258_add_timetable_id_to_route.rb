class AddTimetableIdToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :timetable_id, :integer
  end
end
