Rails.application.routes.draw do
  devise_for :users
  root 'jobs#index'

  resources :jobs do
    member do
      resources :resumes
    end
  end

  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end
    end
  end

end
