AdoptMeme::Application.routes.draw do
  resources :images, :users
  resource :session, :only => [:new, :create, :destroy]
end
