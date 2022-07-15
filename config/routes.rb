Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'events#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users

  devise_scope :user do
    # Redirects signing out users back to sign-in (necessary when deleting user)
    get 'users', to: 'events#index'
  end

  resources :events do
    member do
      post 'attend'
      delete 'absent'
    end
  end

  resources :users
end
