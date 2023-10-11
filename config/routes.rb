Rails.application.routes.draw do
  devise_for :patient

  namespace :api do
    namespace :v1 do
      resources :appointments, only: [:index, :show, :create, :update, :destroy]
      resources :doctors, only: [:index, :show, :create, :destroy]
      resources :specializations, only: [:index, :create]
    end
  end
end
