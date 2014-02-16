class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :name
      t.integer :start_day
      t.integer :end_day
      t.string :description

      t.timestamps
    end
  end
end
