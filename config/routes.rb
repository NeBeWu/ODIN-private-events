Rails.application.routes.draw do
  devise_for :users
  get 'events/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    # Redirects signing out users back to sign-in (necessary when deleting user)
    get 'users', to: 'posts#index'
  end


  # Defines the root path route ("/")
  root 'events#index'
end
