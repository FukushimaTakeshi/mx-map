rails_env = ENV.fetch('RAILS_ENV') { 'development' }
environment rails_env

app_dir = File.expand_path('../..', __FILE__)
directory app_dir

threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
threads threads_count, threads_count

if %w[production staging].member?(rails_env)
  # Logging
  stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true

  # Set master PID and state locations
  pidfile "#{app_dir}/tmp/pids/puma.pid"
  state_path "/#{app_dir}/tmp/pids/puma.state"

  # Change to match your CPU core count
  workers ENV.fetch('WEB_CONCURRENCY') { 2 }

  # Set up socket location
  bind "unix://#{app_dir}/tmp/sockets/puma.sock"

  preload_app!
  # prune_bundler  # if phased_restart

  on_restart do
    ENV['BUNDLE_GEMFILE'] = "#{app_dir}/Gemfile"
  end

  before_fork do
    ActiveRecord::Base.connection_pool.disconnect!
  end

  on_worker_boot do
    ActiveSupport.on_load(:active_record) do
      ActiveRecord::Base.establish_connection
    end
  end

elsif rails_env == 'development'
  port   ENV.fetch('PORT') { 3000 }
  plugin :tmp_restart
end
