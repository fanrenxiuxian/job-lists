Rails.application.routes.draw do
  devise_for :users
  root 'jobs#index'

  resources :messages
  resources :resumes

  resources :jobs do
    member do
      post :collect
      post :cancel_collect
      post :clap
      post :cancel_clap_disdain
      post :disdain
    end
    collection do
      get :collections
      get :claps
      get :search
    end
    resources :resumes
  end

  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
    resources :messages
  end

end
