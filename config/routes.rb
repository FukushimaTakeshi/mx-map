Rails.application.routes.draw do
  resources :prefectures, only: [:index, :show]
end
