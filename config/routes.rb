Rails.application.routes.draw do
  root 'homes#top'
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only:[:show]
  resources :menus, only:[:create, :destroy, :show]
  resources :estimates
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
