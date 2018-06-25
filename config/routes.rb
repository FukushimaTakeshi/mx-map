Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }

  root 'regions#index'

  resources :regions, only: [:index, :show] do
    resources :prefectures, param: :id, only: [:index]
  end

  resources :place_search, only: [:index] do
    collection do
      get :search
    end
  end

  resources :place_details_search, param: :place_id, only: [:show]

  resources :plans, only: [:index, :create, :destroy]

  resources :off_road_circuits, only: [:show, :new, :create, :edit, :update, :destroy]
end
