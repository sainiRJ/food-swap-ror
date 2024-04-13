Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'users/registrations'
   }

   devise_scope :user do
    post "/signup", to: 'users/registrations#google_signup'
    post "/login", to: 'users/sessions#create'
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
