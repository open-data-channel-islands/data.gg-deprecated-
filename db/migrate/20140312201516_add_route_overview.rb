class AddRouteOverview < ActiveRecord::Migration
  def change
    create_table :route_overview do |t|
      t.string :name
      t.text :description
      t.integer :timetable_id

      t.timestamps
    end
  end
end
