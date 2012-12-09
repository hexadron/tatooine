Tatooine::Application.routes.draw do
  
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  get 'reset' => 'home#reset'
  root to: 'home#index', as: :root
  
  resources :courses do
    member do
      post 'enroll'
    end
  end
  
  resources :teachers
  resources :students
  
end
