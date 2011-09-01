require "bundler/capistrano"

require "whenever/capistrano"
set :whenever_command, "bundle exec whenever"

set :application, "example.com"

set :ssh_options, { :forward_agent => true }

# Deploy from your local Git repo by cloning and uploading a tarball
set :scm, :git
set :repository,  "."
set :deploy_via, :copy

set :user, :deploy
set :deploy_to, "/var/www/#{application}"
set :use_sudo, false

role :web, application
role :app, application
role :db,  application, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:restart", "deploy:cleanup"