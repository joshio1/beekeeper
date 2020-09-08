Rails.application.routes.draw do
  apipie
  get 'users/'                                      => 'users#index'
  post 'users/'                                     => 'users#create'
  post 'users/new'                                  => 'users#new'

  namespace :api do
    get 'stonks/'                                   => 'stonks#index'
    post 'stonks/'                                  => 'stonks#create'
    post 'stonks/new'                               => 'stonks#new'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
