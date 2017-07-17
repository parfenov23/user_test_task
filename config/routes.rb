Rails.application.routes.draw do
  namespace :api do
    resources :users do
      member do
        get :sessions
        post :amocrm
        get :amocrm
      end
      collection do
        post :amocrm
        get :amocrm
      end
    end

    resources :sessions
  end

end
