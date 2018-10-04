# config valid only for Capistrano 3.1
lock '3.11.0'

set :application, 'data.gg'
set :repo_url, 'git@github.com:open-data-channel-islands/data.gg.git'
set :deploy_to, '/srv/data'

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 
'config/application.yml', 'public/sitemap.xml', 'config/puma.rb')

set :rvm_type, :user                     # Defaults to: :auto
set :rvm_ruby_version, '2.5.1-p0'      # Defaults to: 'default'