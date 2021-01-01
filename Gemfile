source 'https://rubygems.org'

ruby '2.6.6'

gem 'rails', '6.1.0'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'redis'
gem 'jbuilder'
gem 'webpacker'
gem 'bootsnap', require: false

# view
gem 'slim-rails'
gem 'bulma-rails'
gem 'turbolinks'

# api client
gem 'faraday'

gem 'config'

# user
gem 'devise'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

# admin
# gem 'activeadmin', '1.4.3'

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
  gem 'web-console'
  gem 'listen'
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
