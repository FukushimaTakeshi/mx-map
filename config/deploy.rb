# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :application, 'my_app_name'
set :repo_url, 'git@github.com:FukushimaTakeshi/mx-map.git'
set :deploy_to, '/var/www/rails/mx-map'

set :scm, :git
set :deploy_via, :remote_cache

set :log_level, :debug
set :pty, true # sudo に必要

set :rbenv_type, :user
set :rbenv_ruby, '2.6.0-preview3'
# set :rbenv_path, '/usr/local/rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails puma pumactl)
set :rbenv_roles, :all

set :yarn_flags, '--prefer-offline --production'

append :linked_files, 'config/puma.rb'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'tmp/uploads', 'vendor/bundle', 'public/assets', 'public/uploads/tmp', 'public/uploads/user'

set :puma_conf, "#{shared_path}/config/puma.rb"

set :keep_releases, 5

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do
  desc 'Restart Application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke! 'puma:restart'
    end
  end

  # webサーバー再起動時にキャッシュを削除する
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rails, 'tmp:cache:clear'
      end
    end
  end
end
