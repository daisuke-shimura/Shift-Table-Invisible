Rails.application.routes.draw do
  root to: 'public/homes#top'

  devise_for :admins, controllers: {
    registrations: "admin/registrations",
    sessions: 'admin/sessions'
  }
  #devise_for :users
  devise_for :users, controllers:{
    registrations: "public/registrations",
    sessions: "public/sessions"
  }


  namespace :admin do
    resources :weeks
  end

  scope module: :public do
    resources :weeks
    resources :users
    resources :shifts
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
