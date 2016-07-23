class SetShowOnWebsiteOnDataCategories < ActiveRecord::Migration[5.0]
  def change

    gov_spending = DataCategory.find_by(name: 'Government spending')
    gov_spending.show_on_website = false
    gov_spending.save!
  end
end
