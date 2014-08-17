Rails.application.routes.draw do

  post 'relationships/:id' => 'home#show', :as => 'show_relations'

  root 'home#index'
end
