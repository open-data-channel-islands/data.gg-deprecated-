class AddComingSoonToDataCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :data_categories, :coming_soon, :boolean, null: false, default: false
  end
end
