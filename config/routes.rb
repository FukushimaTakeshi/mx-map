Rails.application.routes.draw do

  resources :regions, only: [:index, :show] do
    resources :prefectures, param: :id, only: [:index]
  end

  resources :place_search, only: [:new, :create]
  resources :place_details_search, param: :place_id, only: [:show]
end
