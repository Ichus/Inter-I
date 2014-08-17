Rails.application.routes.draw do

  post 'relationships/:id' => 'home#show', :as => 'show_relations'
  post 'relationships/:id/:category' => 'home#show', :as => 'show_category_relations'

  root 'home#index'
end
