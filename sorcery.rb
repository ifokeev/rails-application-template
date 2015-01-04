generate 'sorcery:install', 'remember_me'

generate 'migration', 'add_index_on_username_to_users'
inject_into_file Dir['db/migrate/*_add_index_on_username_to_users.rb'].first, <<RUBY, after: "def change\n"
    add_index :users, :username, unique: true
RUBY


remove_file 'app/models/user.rb'
file 'app/models/user.rb',                     cat('app/models/user.rb')
file 'app/controllers/sessions_controller.rb', cat('app/controllers/sessions_controller.rb')
file 'app/controllers/users_controller.rb',    cat('app/controllers/users_controller.rb')
file 'app/views/sessions/new.html.haml',       cat('app/views/sessions/new.html.haml')
file 'app/views/users/index.html.haml',        cat('app/views/users/index.html.haml')
file 'app/views/users/show.html.haml',         cat('app/views/users/show.html.haml')
file 'app/views/users/new.html.haml',          cat('app/views/users/new.html.haml')
file 'app/views/users/edit.html.haml',         cat('app/views/users/edit.html.haml')
file 'app/views/users/_user.html.haml',        cat('app/views/users/_user.html.haml')
file 'app/views/users/_form.html.haml',        cat('app/views/users/_form.html.haml')

route "root to: 'users#index'"
route "post '/sign_out' => 'sessions#destroy', as: :sign_out"
route "post '/sign_in' => 'sessions#new', as: :sign_in"
route "resource :session"
route "resources :users"

remove_file 'public/index.html'

inject_into_file 'app/views/layouts/application.html.haml', <<HAML, after: "#foot\n"
    - if current_user
      You are signed in as \#{current_user.username}
      |
      = link_to 'Sign out', sign_out_path
HAML
file 'app/views/layouts/sessions.html.haml', erb('app/views/layouts/sessions.html.haml')
