class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :forename, :string
    add_column :users, :surname, :string
    add_column :users, :address_line_1, :string
    add_column :users, :address_line_2, :string
    add_reference :users, :parish, index: true, foreign_key: true
    add_column :users, :postcode, :string
    add_column :users, :is_admin, :boolean
  end
end
