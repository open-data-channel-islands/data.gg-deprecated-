class AddTimetableReferenceToStops < ActiveRecord::Migration
  def change
    add_column :stops, :timetable_id, :integer
  end
end
