Rails.application.routes.draw do
  devise_for :users, controllers: {
      passwords: 'users/passwords',
      registrations: 'users/registrations',
      sessions: 'users/sessions',
      omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get 'enable_otp_show_qr', to: "users#enable_otp_show_qr", as: 'enable_otp_show_qr'
  post 'enable_otp_verify', to: "users#enable_otp_verify", as: 'enable_otp_verify'

  get 'users/otp', to: 'users#show_otp', as: 'user_otp'
  post 'users/otp', to: 'users#verify_otp', as: 'verify_user_otp'
  post 'veridy_otp', to: 'users/sessions#verify_otp'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'welcome#index'
  # get '/signup', to: 'users#new', as: 'register_user'
  # get '/login', to: 'sessions#new', as: 'user_login'
  # post '/login', to: 'sessions#create'
  # delete '/logout', to: 'sessions#destroy'
  # get '/auth/google_oauth2/callback', to: 'google_controller#google', as: 'auth_google'

  resources :users, only: [:show, :new, :create] do
    resources :trips do
      resources :daily_itineraries, only: [:index, :show, :new, :create] do
        resources :activities
      end
    end
  end
end
