case @use_admin
  when "1"
    gem 'rails_admin', :git => 'https://github.com/sferik/rails_admin.git'
    run 'bundle install'

    generate 'rails_admin:install'
    initializer 'rails_admin_active_record_enum.rb', cat('config/initializers/rails_admin_active_record_enum.rb')

  when "2"
    gem 'activeadmin', github: 'activeadmin'
    run 'bundle install'

    generate 'active_admin:install', '--skip-users'
  else
    puts "ok..."
end
