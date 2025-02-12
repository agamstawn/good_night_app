Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :sleep_records, only: [:index, :create]
        post :clock_in, to: "sleep_records#clock_in"
        get :following_sleep_records, to: "sleep_records#following_sleep_records"
      end
      resources :follows, only: [:create] do
        delete :destroy, on: :collection
      end
    end
  end
  
end
