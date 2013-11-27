Bubbles::Engine.routes.draw do
  
  resources :conversations, path: '/', only: [:index, :show, :new, :create, :update]

end
