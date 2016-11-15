Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: "users/passwords"
  }

  resources :uploads
  resources :users, :module => "users"
  get 'ambient_content' => 'uploads#ambient_content'
  resources :groups
  get 'render_uploads' => 'groups#render_uploads'
  get 'render_uploads_pagination' => 'groups#render_uploads_pagination'
  get 'groups_count' => 'groups#groups_count'
  get 'ambient_content_count' => 'uploads#ambient_content_count'
  get 'last_updated' => 'uploads#last_updated'

  root 'groups#index'
  get 'admin' => 'static#index'
  get 'home' => 'static#home'

end
