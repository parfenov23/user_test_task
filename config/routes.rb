Rails.application.routes.draw do
  namespace :api do
    resources :users do
      member do
        get :sessions
      end
    end

    resources :sessions
  end

end
