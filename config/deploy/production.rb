set :rails_env, :production
set :stage, :production
set :branch, 'master'
server '13.113.162.140', user: 'fukushima', roles: %w(web app db)

set :ssh_options, keys: ["#{ENV['HOME']}/.ssh/id_rsa"],
                  forward_agent: true,
                  auth_methods: %w(publickey)

set :bundle_path, -> { shared_path.join('vendor/bundle') }
set :bundle_flags, '--deployment'
set :bundle_without, %w(development test).join(' ')
