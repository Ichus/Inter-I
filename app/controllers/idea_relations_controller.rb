require "#{Rails.root}/app/models/idea_relations"

class IdeaRelationsController < ApplicationController
  include IdeaRelations
  helper_method IdeaRelations.instance_methods

  def index
    session[:idea_path] = []
  end

  def show
    @idea = params[:idea]
    @relations = find_relations(@idea)
    @categories = find_categories(@idea)
    params[:category] ? @categorical_relations = categorical_relations(params[:category], @idea) : @categorical_relations = false
    revert_link_followed_history if params[:prev_followed_link]
    session[:idea_path] = [] if params[:path_searched] || !session[:idea_path]
    session[:idea_path] << @idea unless session[:idea_path].last == @idea
  end

  private

  def revert_link_followed_history
    begin
      session[:idea_path].pop
    end until session[:idea_path].last == params[:prev_followed_link]
  end

  def idea_relations_params
    params.permit(:idea, :category)
  end
end
