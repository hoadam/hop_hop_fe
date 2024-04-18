Rails.application.routes.draw do
  devise_for :users, controllers: {
      passwords: 'users/passwords',
      registrations: 'users/registrations',
      sessions: 'users/sessions',
      omniauth_callbacks: 'users/omniauth_callbacks',
  }

  get "/", to: "welcome#index"
  root to: 'pages#home'

  get 'enable_otp_show_qr', to: "users#enable_otp_show_qr", as: 'enable_otp_show_qr'
  post 'enable_otp_verify', to: "users#enable_otp_verify", as: 'enable_otp_verify'
  get 'users/otp', to: 'users#show_otp', as: 'user_otp'
  post 'users/otp', to: 'users#verify_otp', as: 'verify_user_otp'
  post 'veridy_otp', to: 'users/sessions#verify_otp'

  get "up" => "rails/health#show", as: :rails_health_check

  get "/dashboard", to: "users#show", as: :dashboard
  resources :discover, only: [:index]
  resources :trips do
    resources :accommodations
    resources :daily_itineraries, only: [:index, :show] do
      resources :activities
    end
  end
end
