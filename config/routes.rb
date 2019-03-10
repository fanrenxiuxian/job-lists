Rails.application.routes.draw do
  devise_for :users
  root 'jobs#index'

  resources :jobs do
    member do
      post :clap
      post :cancel_clap_disdain
      post :disdain
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

  end

end
