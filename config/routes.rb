Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :groups, only: [:new, :create, :show, :destroy] do
    resources :members, only: [:new, :create, :destroy]
    resources :chatrooms, only: [:new, :create]
  end
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
  post "/users/:nickname/members/new", to: "members#new_member", as: "new_member_user"
  get '/users/:nickname', to: 'users#show', as: 'user'
  patch "/members/:id/accept", to: "members#accept", as: "accept"
  patch "/members/:id/reject", to: "members#reject", as: "reject"
  patch "/members/:id/check", to: "members#check", as: "check"
  get "/dashboard", to: "users#dashboard", as: "dashboard"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
