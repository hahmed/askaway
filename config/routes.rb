Rails.application.routes.draw do
  resources :questions do
    resources :answers, only: [:create, :destroy]
    collection do
      get :autocomplete
    end
  end

  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords',
    registrations: 'users/registrations' }
  get 'welcome' => 'welcome#index'
  root 'welcome#index'
end
