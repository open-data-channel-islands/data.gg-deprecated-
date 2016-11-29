desc "Restart Unicorn"
task :restart_unicorn do
  on roles(:all) do |h|
    execute "sh #{current_path}/config/init.sh restart"
  end
end