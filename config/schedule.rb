require File.expand_path('./environment', __dir__)
set :output, "#{Rails.root}/log/cron_log.log"

rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env

every :sunday, at: '9am' do
  rake 'chache_contents:place_details_search'
end

every :sunday, at: '10am' do
  rake 'chache_contents:place_image'
end
