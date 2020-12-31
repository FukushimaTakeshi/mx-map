source 'https://rubygems.org'

ruby '2.6.6'

gem 'rails', '5.2.0'
gem 'puma', '3.11.4'
gem 'sass-rails', '5.0.7'
gem 'uglifier', '4.1.12'
gem 'redis-rails', '5.0.2'
gem 'jbuilder', '2.7.0'
gem 'webpacker', '3.5.3'
gem 'bootsnap', '1.3.0', require: false

# view
gem 'slim-rails', '3.1.3'
gem 'bulma-rails', '0.7.2'
gem 'turbolinks', '5.1.1'

# api client
gem 'faraday', '0.15.2'

gem 'config', '1.7.0'

# user
gem 'devise', '4.4.3'
gem 'omniauth-twitter', '1.4.0'
gem 'omniauth-facebook', '1.4.0'
gem 'omniauth-google-oauth2', '0.2.2'

# admin
gem 'activeadmin', '1.3.1'

gem 'carrierwave', '1.2.3'
gem 'mini_magick', '4.8.0'

# markdown
gem 'redcarpet', '3.4.0'

gem 'meta-tags', '2.10.0'

gem 'whenever', '0.10.0', require: false

group :production do
  gem 'mysql2', '0.5.1'
  gem 'google-analytics-rails', '1.1.1'
  gem 'newrelic_rpm', '5.5.0.348'
end

group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug', '10.0.2', platforms: [:mri, :mingw, :x64_mingw]
  gem 'better_errors', '2.4.0'
  gem 'binding_of_caller', '0.8.0'
  gem 'rspec-rails', '3.7.2'
  gem 'rails-controller-testing', '1.0.2'
  gem 'factory_bot_rails', '4.10.0'
  gem 'webmock', '3.4.2', require: false
end

group :development do
  gem 'web-console', '3.6.2'
  gem 'listen', '3.1.5'
  gem 'letter_opener', '1.6.0'
  gem 'letter_opener_web', '1.3.4'
  gem 'bullet', '5.9.0'

  # deploy tools
  gem 'capistrano', '3.11.0', require: false
  gem 'capistrano-rails', '1.4.0', require: false
  gem 'capistrano-bundler', '1.3.0', require: false
  gem 'capistrano-yarn', '2.0.2', require: false
  gem 'capistrano3-puma', '3.1.1', require: false
  gem 'capistrano-rbenv', '2.1.4', require: false
end
