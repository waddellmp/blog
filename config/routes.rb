Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get 'up' => 'rails/health#show', as: :rails_health_check

  # [Controller#Action]
  # The root route defaults to "/". Default name is root. So you can omit the :as and url.
  resources :blog_posts
  root 'blog_posts#index', to: 'blog_posts#index', as: :root
end
