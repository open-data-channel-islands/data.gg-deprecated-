class  CreateDataSets  <  ActiveRecord::Migration
    def  change
        create_table  :data_sets  do  |t|
            t.string  :name
            t.string  :desc
            t.string  :stub
            t.string  :filename
            t.boolean  :live
            t.string  :source_url
            t.references  :data_category,  index:  true,  foreign_key:  true

            t.timestamps  null:  false
        end
    end
end
