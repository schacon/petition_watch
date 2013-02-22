Finance::Application.routes.draw do
  #match 'site/:id' => 'catalog#view'
  match '/auth/github/callback' => 'site#login'
  match '/logout' => 'site#logout'
  root :to => 'site#index'
end
