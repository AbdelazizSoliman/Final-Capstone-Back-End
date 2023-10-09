Rails.application.routes.draw do
  devise_for :patients
 
  namespace :api do
    namespace :v1 do
      resources :patients
      get '/patient/appointments', to: 'patients#appointments'
      resources :doctors do
        resources :appointments
      end
    end
  end
end
