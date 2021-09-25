Myrottenpotatoes::Application.routes.draw do

  resources :movies
  root :to => redirect('/movies')

  # fb authentication
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

end
