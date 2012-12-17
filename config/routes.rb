Editor::Application.routes.draw do
  resources :documents
  resources :howlers
  root :to => "documents#index"
end
