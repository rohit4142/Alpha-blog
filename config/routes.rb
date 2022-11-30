Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "users#home"

   resources :users do
             resources :articles
            end
  get 'login', to: 'users#login'

  get 'user/:user_id/article' , to: 'users#articles'

  delete 'users/:user_id/articles', to: 'articles#destroy_all'

end
