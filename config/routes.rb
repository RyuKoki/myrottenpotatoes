Myrottenpotatoes::Application.routes.draw do

  resources :movies do
    resources :reviews
  end

  root :to => redirect('/movies')

  # fb authentication
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

end
