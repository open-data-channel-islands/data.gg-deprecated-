class  CreatePlaces  <  ActiveRecord::Migration
    def  change
        create_table  :places  do  |t|
            t.string  :name
            t.string  :code

            t.timestamps  null:  false
        end
    end
end
