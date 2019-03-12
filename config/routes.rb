Rails.application.routes.draw do
  resources :posts
  resources :categories
  resources :authors, only: [:index, :show]
  post "comment", to: "comments#create"
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "categories#index"

end
