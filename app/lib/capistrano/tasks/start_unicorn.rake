desc  "Start  Unicorn"
task  :start_unicorn  do
    on  roles(:all)  do  |h|
        execute  "sh  #{current_path}/config/init.sh  start"
    end
end