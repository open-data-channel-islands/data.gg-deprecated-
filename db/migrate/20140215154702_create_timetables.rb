class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.datetime :effective_date
      t.string :name

      t.timestamps
    end
  end
end
