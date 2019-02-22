source 'https://rubygems.org'

ruby '2.6.0'

gem 'rails', '~> 5.2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'redis-rails'
gem 'jbuilder', '~> 2.5'
gem 'webpacker'
gem 'bootsnap', '>= 1.1.0', require: false

# view
gem 'slim-rails'
gem 'bulma-rails'
gem 'turbolinks', '~> 5'

# api client
gem 'faraday'

gem 'config'

# user
gem 'devise'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

# admin
gem 'activeadmin'

gem 'carrierwave'
gem 'mini_magick'

# markdown
gem 'redcarpet'

gem 'meta-tags'

gem 'whenever', require: false

group :production do
  gem 'mysql2', '>= 0.4.4', '< 0.6.0'
  gem 'google-analytics-rails'
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'sqlite3'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'factory_bot_rails'
  gem 'webmock', require: false
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'letter_opener'
  gem 'letter_opener_web'
  gem 'bullet'

  # deploy tools
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-yarn', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-rbenv', require: false
end
