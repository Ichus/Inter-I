Rails.application.routes.draw do

  get 'relationships/:id/idea' => 'home#show', :as => 'show_relations'

  root 'home#index'
end
