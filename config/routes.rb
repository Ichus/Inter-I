Rails.application.routes.draw do
  get 'relationships/:id' => 'idea_relations#show', :as => 'show_relations'
  get 'relationships/:id/:category' => 'idea_relations#show', :as => 'show_categorical_relations'

  root 'idea_relations#index'
end
