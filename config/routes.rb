Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }
  resources :users, only: [:index, :show]

  root 'regions#index'

  resources :regions, only: [:index], shallow: true do
    resources :prefectures, only: [:show]
  end

  resources :place_search, only: [:index] do
    collection do
      get :search
    end
  end

  resources :place_details_search, param: :place_id, only: [:show]

  resources :off_road_circuits, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :plans, only: [:index]
  end

  namespace :api do
    resources :plans, only: [:index, :create, :destroy]
  end
end
