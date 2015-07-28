Rails.application.routes.draw do
  
  concern :match do
    resources :matches
  end
  
  resources :games

  concern :admin_match do
    resources :matches, shallow: true
  end
# 
#  resources :match
  resources :tournaments,only: [:index, :show] do 
    concerns :match
  end
  concerns :match
  
  namespace :admin do
    resources :tournaments
  end

  resources :players, module: :admin
  scope 'admin', as: 'admin_reports' do
    resources :reports
  end
  resources :reports do
    get 'download_csv', on: :collection
    get 'download_pdf', on: :member
  end
  # resources :tournament
  
  post 'login',to: 'users#login'
  root 'tournaments#dashboard'
  resources :match_points, as: :scores
end
