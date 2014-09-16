Rails.application.routes.draw do
  get 'relationships/:idea' => 'idea_relations#show', :as => 'show_relations'
  get 'relationships/:idea/:category' => 'idea_relations#show', :as => 'show_categorical_relations'

  root 'idea_relations#index'
end
