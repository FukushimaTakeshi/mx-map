Rails.application.routes.draw do
  resources :regions, only: [:index, :show] do
    resources :prefectures, param: :id, only: [:index]
  end
end
