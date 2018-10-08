rails_env = ENV.fetch('RAILS_ENV') { 'development' }
environment rails_env

threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
threads threads_count, threads_count

app_dir = File.expand_path('../..', __FILE__)

if %w[production staging].member?(rails_env)
  # Logging
  # stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true

  # Set master PID and state locations
  pidfile "#{app_dir}/tmp/pids/puma.pid"
  state_path "/#{app_dir}/tmp/pids/puma.state"

  # Change to match your CPU core count
  workers ENV.fetch('WEB_CONCURRENCY') { 2 }

  preload_app!

  # Set up socket location
  bind "unix://#{app_dir}/tmp/sockets/puma.sock"
  
  # before_fork do
  #   # app does not use database, uncomment when needed
  #   # ActiveRecord::Base.connection_pool.disconnect!
  # end
  # 
  # on_worker_boot do
  #   ActiveSupport.on_load(:active_record) do
  #     # app does not use database, uncomment when needed
  #     # db_url = ENV.fetch('DATABASE_URL')
  #     # puts "puma: connecting to DB at #{db_url}"
  #     # ActiveRecord::Base.establish_connection(db_url)
  #   end
  # end
elsif rails_env == 'development'
  port   ENV.fetch('PORT') { 3000 }
  plugin :tmp_restart
end
