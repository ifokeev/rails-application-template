require File.join(File.dirname(__FILE__), 'helpers.rb')
apply File.join(File.dirname(__FILE__), 'gems.rb')

gsub_file 'config/database.yml', /username: #{app_name}$/, "username: #{database_username}"
rake 'db:create'

generate 'rspec:install'

apply File.join(File.dirname(__FILE__), 'urgetopunt.rb')


inject_into_file 'config/application.rb', <<-RUBY, after: "class Application < Rails::Application\n"
    # Use raw SQL schema format - default ruby version doesn't support advanced db features
    config.active_record.schema_format = :sql

    # Don't initialize on assets:precompile (needed when deploying to Heroku)
    config.assets.initialize_on_precompile = false

    #autoload scripts from lib
    config.autoload_paths << Rails.root.join('lib')

    config.time_zone = 'Moscow'
    config.assets.paths << "#{Rails}/vendor/assets/fonts"
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    Paperclip.options[:command_path] = "/usr/local/bin/identify"
RUBY

gsub_file 'config/application.rb', /# config\.autoload_paths \+= .*/, 'config.autoload_paths += %W(#{config.root}/lib)'

gsub_file 'config/environments/test.rb', /# (config.active_record.schema_format = :sql)/, '\1'

remove_file 'app/views/layouts/application.html.erb'
file 'app/views/layouts/application.html.haml', erb('app/views/layouts/application.html.haml')

apply File.join(File.dirname(__FILE__), 'sorcery.rb') if use_sorcery?

remove_file 'app/assets/stylesheets/application.css'
file "app/assets/stylesheets/application.css.scss", cat('app/assets/stylesheets/application.css.scss')

remove_file 'app/assets/javascripts/application.js'
file "app/assets/javascripts/application.js.coffee", cat('app/assets/javascripts/application.js.coffee')

generate 'simple_form:install', '--bootstrap'

if require_ssl?
  gsub_file 'config/environments/production.rb', /# (config\.force_ssl = true)/, '\1'
end

append_file '.gitignore', <<GIT
.idea/*
*.iml
*.ipr
*.iws
*.swp
*~
#*#
.DS_Store
config/database.yml
GIT


initializer 'will_paginate.rb', cat('config/initializers/will_paginate.rb')
apply File.join(File.dirname(__FILE__), 'devise.rb') if !use_sorcery? && use_devise?
apply File.join(File.dirname(__FILE__), 'admin.rb')  if use_admin?


if !use_sorcery?
  file 'app/controllers/welcome_controller.rb',    cat('app/controllers/welcome_controller.rb')
  file 'app/views/welcome/index.html.haml',    cat('app/views/welcome/index.html.haml')
  route "root to: 'welcome#index'"
end


rake 'db:migrate'
# after_bundle do
#   git :init
#   git add: "."
#   git commit: %Q{ -m 'Initial commit' }
# end