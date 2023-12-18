Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'cities/weather', to: 'cities#weather'
      resources :health, only: [:index]
    end
  end
end
