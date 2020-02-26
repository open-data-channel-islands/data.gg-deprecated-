#  This  file  is  auto-generated  from  the  current  state  of  the  database.  Instead
#  of  editing  this  file,  please  use  the  migrations  feature  of  Active  Record  to
#  incrementally  modify  your  database,  and  then  regenerate  this  schema  definition.
#
#  Note  that  this  schema.rb  definition  is  the  authoritative  source  for  your
#  database  schema.  If  you  need  to  create  the  application  database  on  another
#  system,  you  should  be  using  db:schema:load,  not  running  all  the  migrations
#  from  scratch.  The  latter  is  a  flawed  and  unsustainable  approach  (the  more  migrations
#  you'll  amass,  the  slower  it'll  run  and  the  greater  likelihood  for  issues).
#
#  It's  strongly  recommended  that  you  check  this  file  into  your  version  control  system.

ActiveRecord::Schema.define(version:  20180222120301)  do

    #  These  are  extensions  that  must  be  enabled  in  order  to  support  this  database
    enable_extension  "plpgsql"

    create_table  "alerts",  id:  :serial,  force:  :cascade  do  |t|
        t.text  "message"
        t.boolean  "active"
        t.integer  "level"
        t.datetime  "created_at",  null:  false
        t.datetime  "updated_at",  null:  false
    end

    create_table  "data_categories",  id:  :serial,  force:  :cascade  do  |t|
        t.string  "name"
        t.string  "image"
        t.string  "desc"
        t.string  "stub"
        t.datetime  "created_at",  null:  false
        t.datetime  "updated_at",  null:  false
        t.boolean  "coming_soon",  default:  false,  null:  false
        t.boolean  "show_on_website",  default:  true,  null:  false
    end

    create_table  "data_sets",  id:  :serial,  force:  :cascade  do  |t|
        t.string  "name"
        t.string  "desc"
        t.string  "stub"
        t.string  "filename"
        t.boolean  "live"
        t.string  "source_url"
        t.integer  "data_category_id"
        t.datetime  "created_at",  null:  false
        t.datetime  "updated_at",  null:  false
        t.integer  "place_id"
        t.index  ["data_category_id"],  name:  "index_data_sets_on_data_category_id"
        t.index  ["place_id"],  name:  "index_data_sets_on_place_id"
    end

    create_table  "parishes",  id:  :serial,  force:  :cascade  do  |t|
        t.string  "name"
        t.datetime  "created_at",  null:  false
        t.datetime  "updated_at",  null:  false
    end

    create_table  "places",  id:  :serial,  force:  :cascade  do  |t|
        t.string  "name"
        t.string  "code"
        t.datetime  "created_at",  null:  false
        t.datetime  "updated_at",  null:  false
    end

    create_table  "users",  id:  :serial,  force:  :cascade  do  |t|
        t.string  "email",  default:  "",  null:  false
        t.string  "encrypted_password",  default:  "",  null:  false
        t.string  "reset_password_token"
        t.datetime  "reset_password_sent_at"
        t.datetime  "remember_created_at"
        t.integer  "sign_in_count",  default:  0,  null:  false
        t.datetime  "current_sign_in_at"
        t.datetime  "last_sign_in_at"
        t.inet  "current_sign_in_ip"
        t.inet  "last_sign_in_ip"
        t.datetime  "created_at",  null:  false
        t.datetime  "updated_at",  null:  false
        t.string  "forename"
        t.string  "surname"
        t.string  "address_line_1"
        t.string  "address_line_2"
        t.integer  "parish_id"
        t.string  "postcode"
        t.boolean  "is_admin"
        t.index  ["email"],  name:  "index_users_on_email",  unique:  true
        t.index  ["parish_id"],  name:  "index_users_on_parish_id"
        t.index  ["reset_password_token"],  name:  "index_users_on_reset_password_token",  unique:  true
    end

    add_foreign_key  "data_sets",  "data_categories"
    add_foreign_key  "data_sets",  "places"
    add_foreign_key  "users",  "parishes"
end
