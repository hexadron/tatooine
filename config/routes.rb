Tatooine::Application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get 'reset' => 'home#reset'
  root to: 'home#index', as: :root
end
