Finance::Application.routes.draw do
  #match 'site/:id' => 'catalog#view'
  match '/auth/github/callback' => 'site#login'
  root :to => 'site#index'
end
