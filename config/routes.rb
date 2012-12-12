Tatooine::Application.routes.draw do
  
  get "feedbacks/create"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  get 'reset' => 'home#reset'
  root to: 'home#index', as: :root
  
  resources :courses do
    resources :feedbacks
    member do
      post 'enroll'
    end
    collection do
      get 'search'
    end
  end
  
  resources :teachers
  resources :students
  
end
