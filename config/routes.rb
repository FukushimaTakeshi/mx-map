Rails.application.routes.draw do

  root 'regions#index'

  resources :regions, only: [:index, :show] do
    resources :prefectures, param: :id, only: [:index]
  end

  resources :place_search, only: [:new, :create]

  resources :place_details_search, param: :place_id, only: [:show, :new, :create]

  resources :plans, only: [:index, :create, :destroy]

  resources :off_road_circuits, only: [:show, :edit, :update, :destroy]
end
