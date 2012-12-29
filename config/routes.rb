Tatooine::Application.routes.draw do
  
  get "feedbacks/create"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  
  get '/admin/locale/:locale' => 'admin/dashboard#set_locale'

  get 'reset' => 'home#reset'
  root to: 'home#index', as: :root
  
  resources :courses do    
    resources :feedbacks
    resources :course_sessions do
      resources :sections
      member do
        post 'resort'
      end
    end
    member do
      post 'enroll'
      get 'faq'
    end
    collection do
      get 'search'
    end
  end
  
  resources :sections do
    resources :exercises
  end
  
  resources :exercises do
    member do
      put 'customize'
      put 'solve'
    end
  end
  
  resources :teachers
  resources :students
  resources :users
  
end