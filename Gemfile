source 'https://rubygems.org'

gem 'rails', '>= 5.0.0.rc1', '< 5.1'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rack-cors', require: 'rack/cors', group: [:development, :staging, :test, :production]

gem 'bcrypt', '~> 3.1.11'
gem 'activerecord-postgis-adapter', '~> 4.0.0.beta'
gem 'carrierwave'
gem 'carrierwave-base64'
gem 'mini_magick'
gem 'active_model_serializers', '~> 0.10.0'
gem 'kaminari'
gem 'koala', '~> 2.2'
gem 'faker'
gem 'mandrill-api'
gem 'grocer'
gem 'gcm'
gem 'settingslogic'
gem 'whenever', require: false
gem 'unicorn-rails'
gem 'json-jwt'
gem 'posix-spawn'
gem 'act-fluent-logger-rails'
gem 'lograge'
gem 'haversine'
gem 'layer-ruby', require: 'layer'
gem 'sidekiq', '~> 4.2.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '3.1.0'
  gem 'factory_girl_rails'
end

group :development do
  gem 'awesome_print'
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', '~> 0.40.0', require: false
  gem 'ruby-lint', require: false
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
