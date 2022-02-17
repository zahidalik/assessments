Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#home"

  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  delete 'logout', to: "sessions#destroy"
  
  resources :teachers do
    resources :classrooms do
      resources :subject_assessments
    end
  end

  resources :users do
    resources :user_roles
  end
  
  resources :roles
end