Rails.application.routes.draw do
  
  devise_for :users

  concern :match do
    resources :matches
  end
  
  resources :games

#  resources :match
  resources :tournaments,only: [:index, :show] do 
    resources :matches
  end
 
  resources :games do
    resources :tournaments
  end

  resources :games do
    resources :matches
  end

  resources :tournaments do
    resources :matches do
      resources :players
    end
  end

  resources :games do
    resources :matches do
      resources :players
    end
  end

  #resource :login, only: [:index, :new, :create]
  resource :login, only: [:create, :show]

  root 'tournaments#dashboard'

  resources :players


  #namespace :admin do
  #  resources :tournaments
  #end
  
  #scope 'admin', as: 'admin_reports' do
  #  resources :reports
  #end
  
  #resources :reports do
  #  get 'download_csv', on: :collection
  #get 'download_pdf', on: :member
  #end
  # resources :tournament

  #resources :match_points, as: :scores

end
