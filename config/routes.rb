AdoptMeme::Application.routes.draw do
  resources :users, :only => [:index, :new, :create]
  resource :session, :only => [:new, :create, :destroy]
  root :to => "pets#index"
  get '/:petid', to: "pets#show"
  get '/:petid/new', to: "captions#new"
  get '/:petid/:captionid', to: "captions#show"
end
