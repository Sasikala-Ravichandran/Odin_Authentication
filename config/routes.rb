Rails.application.routes.draw do   

  get 'login' => 'session#new'
  post 'login' => 'session#create'
  delete 'logout' => 'session#delete'
  resources :users

end