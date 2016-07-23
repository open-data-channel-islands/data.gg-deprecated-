class SetShowOnWebsiteOnDataCategories < ActiveRecord::Migration[5.0]
  def change
    DataCategory.reset_column_information
    gov_spending = DataCategory.find_by(name: 'Government spending')
    gov_spending.update!(show_on_website: false)
  end
end
