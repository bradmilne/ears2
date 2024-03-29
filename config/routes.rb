Ears2::Application.routes.draw do
  get "lessons/show"
  get "stats/show"
  match '/about' => 'home#about', :via => [:get]
  match '/pricing' => 'home#pricing', :via => [:get]
  get "home/pricing"


  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  mount StripeEvent::Engine => '/stripe'
  get "content/gold"
  get "content/silver"
  get "content/platinum"
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :registrations => 'registrations' }
  devise_scope :user do
    put 'update_plan', :to => 'registrations#update_plan'
    put 'update_card', :to => 'registrations#update_card'
  end
  resources :users
  resources :lessons, :only => [:show, :index]
  resources :lessons do
    resources :quizzes, :only => [:index, :show, :new, :create]
  end


end