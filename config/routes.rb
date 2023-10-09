Rails.application.routes.draw do
  devise_for :patients
 
 namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      resources :doctors, only: [:index, :show, :new, :create, :destroy] 
      resources :appointments, only: [:index, :show, :new, :create, :destroy]
      resources :specializations, only: [:index, :create]
    end
  end
end
