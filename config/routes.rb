Rails.application.routes.draw do

  get 'relationships/:id' => 'home#show', :as => 'show_relations'
  get 'relationships/:id/:category' => 'home#show', :as => 'show_category_relations'

  root 'home#index'
end
