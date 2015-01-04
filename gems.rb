#чтобы было красиво
gem_group :development do
  gem 'quiet_assets'
  gem "better_errors"
  gem "binding_of_caller"
end

gem_group :test do
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'mocha'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'orderly'
  gem 'launchy'
  gem 'spork'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'simplecov', require: false
end

gem 'rspec-rails', group: [:test, :development]
gem 'ffaker', group: [:test, :development]

gem 'mysql2', group: :production

gem 'haml'
gem 'haml-rails'
gem "paperclip", "~> 4.2"
gem 'simple_form'
gem 'jquery-turbolinks'

# Internationalization
gem 'rails-i18n', '~> 4.0.0'
gem 'russian', '~> 0.6.0'

#bootstrap
gem 'bootstrap-sass', '~> 3.3.1'
gem 'sprockets'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'autoprefixer-rails'
gem 'font-awesome-sass'

#pagination
gem 'will_paginate', '~> 3.0'
gem 'will_paginate-bootstrap'


gem 'sorcery' if use_sorcery?
gem 'devise'  if use_devise?

run 'bundle install'