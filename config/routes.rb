Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users
  # FIXME route broken
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :wikis
  get 'about' => 'welcome#about'
end
