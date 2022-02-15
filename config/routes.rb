Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#home"
  
  resources :teachers do
    resources :classrooms do
      resources :subject_assessments
    end
  end
end