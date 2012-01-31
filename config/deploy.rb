# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.    
require "rvm/capistrano"
set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user  # Don't use system-wide RVM

require 'bundler/capistrano'

set :application, 'ucheke_pre'
set :domain,      '58.215.170.153' #ucheke.com  50.57.160.177
set :project,     'ucheke_pre'

set :user, 'deploy'

# Setup git
set :scm, :git
set :scm_username, 'he9lin'
set :repository, "git@github.com:#{scm_username}/#{project}.git"
set :branch, 'master'

set :deploy_to, "/var/www/apps/#{application}"
# set :deploy_via, :remote_cache

# Setup user level
set :run, user
set :use_sudo, false

# Setup roles
role :app, domain
role :web, domain
role :db,  domain, :primary => true

# Thin start, stop and restart
namespace :deploy do
  desc "start app"
  task :start, :roles => :app do
    run "cd #{current_path};thin start -e production -d"
  end
  task :stop, :roles => :app do
    run "cd #{current_path};thin stop -e production"
  end
end