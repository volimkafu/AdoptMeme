AdoptMeme::Application.routes.draw do
  resources :images, :users
  resource :session, :only => [:new, :create, :destroy]
  resources :pets, :only => [:index]
  root :to => "pets#index"
end
