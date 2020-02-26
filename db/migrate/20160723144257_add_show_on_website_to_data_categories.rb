class  AddShowOnWebsiteToDataCategories  <  ActiveRecord::Migration[5.0]
    def  change
        add_column  :data_categories,  :show_on_website,  :boolean,  null:  false,  default:  true
    end
end
