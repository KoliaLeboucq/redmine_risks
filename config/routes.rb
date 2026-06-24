Rails.application.routes.draw do
  resources :projects, only: [] do
    resources :risks, only: [:index, :new, :create] do
      collection { get :dashboard }
    end
  end

  resources :risks, only: [:show, :edit, :update, :destroy] do
    resources :risk_reviews,            only: [:new, :create]
    resources :risk_mitigation_actions, only: [:new, :create, :edit, :update, :destroy]
  end
end
