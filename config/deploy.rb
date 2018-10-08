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
set :rbenv_ruby, '2.5.0'
# set :rbenv_path, '/usr/local/rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails puma pumactl)
set :rbenv_roles, :all

set :yarn_flags, '--prefer-offline --production'

append :linked_files, 'config/master.key', 'config/puma.rb'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'tmp/uploads', 'vendor/bundle', 'public/assets', 'public/uploads/tmp', 'public/uploads/user'

set :puma_conf, "#{shared_path}/config/puma.rb"
# capistrano3-puma の既定の再起動処理を無効化
set :puma_default_hooks, false
# puma を capistrano で利用するための設定
set :puma_preload_app, false
set :prune_bundler, true

set :keep_releases, 5

namespace :deploy do
  # desc 'reload the database with seed data'
  # task :seed do
  #   on primary fetch(:migration_role) do
  #     within release_path do
  #       with rails_env: fetch(:rails_env) do
  #         execute :rake, 'db:seed'
  #       end
  #     end
  #   end
  # end
  # 
  desc 'Restart application'  
  task :restart do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        invoke 'puma:phased-restart'
      end
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

  # linked_files で使用するファイルをアップロードするタスク
  # deployが行われる前に実行する必要がある。
  desc 'Upload config files'
  task :upload_config do
    on roles(:app) do
      execute :mkdir, '-p', shared_path.join('config')
      upload!('config/master.key', "#{shared_path}/config/master.key")
      upload!('config/puma.rb', "#{shared_path}/config/puma.rb")
    end
  end
  
  # Flow の before, after のタイミングで上記タスクを実行
  before :started, 'deploy:upload_config'
  after :finishing, :restart
end
