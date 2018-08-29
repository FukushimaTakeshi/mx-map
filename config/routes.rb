Rails.application.routes.draw do
  
  get '/terms', to: 'static_pages#terms'
  get '/privacy', to: 'static_pages#privacy'

  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }

  resources :users, only: [:index, :show, :edit, :update]

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
  
  resource :inquiry, only: [:new, :create], path_names: { new: '' } do
    collection do
      post :confirm
    end
  end

  namespace :api do
    resources :plans, only: [:index, :create, :destroy]
  end
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
