desc  "Stop  Unicorn"
task  :stop_unicorn  do
    on  roles(:all)  do  |h|
        execute  "sh  #{current_path}/config/init.sh  stop"
    end
end