class CreateDataCategories < ActiveRecord::Migration
  def change
    create_table :data_categories do |t|
      t.string :name
      t.string :image
      t.string :desc
      t.string :stub

      t.timestamps null: false
    end

  end
end
