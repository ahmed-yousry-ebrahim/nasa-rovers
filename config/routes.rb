Rails.application.routes.draw do
  post 'results' => 'home#results'
  
  root 'home#new'

end
